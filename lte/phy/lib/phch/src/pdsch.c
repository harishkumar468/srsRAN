/**
 *
 * \section COPYRIGHT
 *
 * Copyright 2013-2014 The libLTE Developers. See the
 * COPYRIGHT file at the top-level directory of this distribution.
 *
 * \section LICENSE
 *
 * This file is part of the libLTE library.
 *
 * libLTE is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 3 of
 * the License, or (at your option) any later version.
 *
 * libLTE is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * A copy of the GNU Lesser General Public License can be found in
 * the LICENSE file in the top-level directory of this distribution
 * and at http://www.gnu.org/licenses/.
 *
 */

#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <math.h>

#include "prb.h"
#include "liblte/phy/phch/pdsch.h"
#include "liblte/phy/common/phy_common.h"
#include "liblte/phy/utils/bit.h"
#include "liblte/phy/utils/debug.h"
#include "liblte/phy/utils/vector.h"


#define MAX_PDSCH_RE(cp) (2 * CP_NSYMB(cp) * 12)



const static lte_mod_t modulations[4] =
    { LTE_BPSK, LTE_QPSK, LTE_QAM16, LTE_QAM64 };
    
//#define DEBUG_IDX

#ifdef DEBUG_IDX    
cf_t *offset_original=NULL;
extern int indices[100000];
extern int indices_ptr; 
#endif


int pdsch_cp(pdsch_t *q, cf_t *input, cf_t *output, ra_prb_t *prb_alloc,
    uint32_t nsubframe, bool put) {
  uint32_t s, n, l, lp, lstart, lend, nof_refs;
  bool is_pbch, is_sss;
  cf_t *in_ptr = input, *out_ptr = output;
  uint32_t offset = 0;

  INFO("%s %d RE from %d PRB\n", put ? "Putting" : "Getting",
      prb_alloc->re_sf[nsubframe], prb_alloc->slot[0].nof_prb);

#ifdef DEBUG_IDX    
  indices_ptr = 0; 
  if (put) {
    offset_original = output; 
  } else {
    offset_original = input;     
  }
#endif
  
  if (q->cell.nof_ports == 1) {
    nof_refs = 2;
  } else {
    nof_refs = 4;
  }

  for (s = 0; s < 2; s++) {
    for (l = 0; l < CP_NSYMB(q->cell.cp); l++) {
      for (n = 0; n < q->cell.nof_prb; n++) {

        // If this PRB is assigned
        if (prb_alloc->slot[s].prb_idx[n]) {
          if (s == 0) {
            lstart = prb_alloc->lstart;
          } else {
            lstart = 0;
          }
          lend = CP_NSYMB(q->cell.cp);
          is_pbch = is_sss = false;

          // Skip PSS/SSS signals
          if (s == 0 && (nsubframe == 0 || nsubframe == 5)) {
            if (n >= q->cell.nof_prb / 2 - 3
                && n < q->cell.nof_prb / 2 + 3) {
              lend = CP_NSYMB(q->cell.cp) - 2;
              is_sss = true;
            }
          }
          // Skip PBCH
          if (s == 1 && nsubframe == 0) {
            if (n >= q->cell.nof_prb / 2 - 3
                && n < q->cell.nof_prb / 2 + 3) {
              lstart = 4;
              is_pbch = true;
            }
          }
          lp = l + s * CP_NSYMB(q->cell.cp);
          if (put) {
            out_ptr = &output[(lp * q->cell.nof_prb + n)
                * RE_X_RB];
          } else {
            in_ptr = &input[(lp * q->cell.nof_prb + n)
                * RE_X_RB];
          }
          // This is a symbol in a normal PRB with or without references
          if (l >= lstart && l < lend) {
            if (SYMBOL_HAS_REF(l, q->cell.cp, q->cell.nof_ports)) {
              if (nof_refs == 2 && l != 0) {    
                offset = q->cell.id % 3 + 3;
              } else {
                offset = q->cell.id % 3;
              }
              prb_cp_ref(&in_ptr, &out_ptr, offset, nof_refs, nof_refs, put);
            } else {
              prb_cp(&in_ptr, &out_ptr, 1);
            }
          }
          // This is a symbol in a PRB with PBCH or Synch signals (SS). 
          // If the number or total PRB is odd, half of the the PBCH or SS will fall into the symbol
          if ((q->cell.nof_prb % 2) && ((is_pbch && l < lstart) || (is_sss && l >= lend))) {
            if (n == q->cell.nof_prb / 2 - 3) {
              if (SYMBOL_HAS_REF(l, q->cell.cp, q->cell.nof_ports)) {
                prb_cp_ref(&in_ptr, &out_ptr, offset, nof_refs, nof_refs/2, put);
              } else {
                prb_cp_half(&in_ptr, &out_ptr, 1);
              }
            } else if (n == q->cell.nof_prb / 2 + 3) {
              if (put) {
                out_ptr += 6;
              } else {
                in_ptr += 6;
              }
              if (SYMBOL_HAS_REF(l, q->cell.cp, q->cell.nof_ports)) {
                prb_cp_ref(&in_ptr, &out_ptr, offset, nof_refs, nof_refs/2, put);
              } else {
                prb_cp_half(&in_ptr, &out_ptr, 1);
              }
            }
          }
        }
      }      
    }
  }
  
  int r; 
  if (put) {
    r = abs((int) (input - in_ptr));
  } else {
    r = abs((int) (output - out_ptr));
  }

  return r; 
}

/**
 * Puts PDSCH in slot number 1
 *
 * Returns the number of symbols written to sf_symbols
 *
 * 36.211 10.3 section 6.3.5
 */
int pdsch_put(pdsch_t *q, cf_t *pdsch_symbols, cf_t *sf_symbols,
    ra_prb_t *prb_alloc, uint32_t subframe) {
  return pdsch_cp(q, pdsch_symbols, sf_symbols, prb_alloc, subframe, true);
}

/**
 * Extracts PDSCH from slot number 1
 *
 * Returns the number of symbols written to PDSCH
 *
 * 36.211 10.3 section 6.3.5
 */
int pdsch_get(pdsch_t *q, cf_t *sf_symbols, cf_t *pdsch_symbols,
    ra_prb_t *prb_alloc, uint32_t subframe) {
  return pdsch_cp(q, sf_symbols, pdsch_symbols, prb_alloc, subframe, false);
}

/** Initializes the PDCCH transmitter and receiver */
int pdsch_init(pdsch_t *q, lte_cell_t cell) {
  int ret = LIBLTE_ERROR_INVALID_INPUTS;
  int i;

 if (q                         != NULL                  &&
     lte_cell_isvalid(&cell)) 
  {   
    
    bzero(q, sizeof(pdsch_t));
    ret = LIBLTE_ERROR;
    
    q->cell = cell;
    q->max_symbols = q->cell.nof_prb * MAX_PDSCH_RE(q->cell.cp);

    INFO("Init PDSCH: %d ports %d PRBs, max_symbols: %d\n", q->cell.nof_ports,
        q->cell.nof_prb, q->max_symbols);

    if (precoding_init(&q->precoding, SF_LEN_RE(cell.nof_prb, cell.cp))) {
      fprintf(stderr, "Error initializing precoding\n");
      goto clean; 
    }

    for (i = 0; i < 4; i++) {
      if (modem_table_lte(&q->mod[i], modulations[i], true)) {
        goto clean;
      }
    }

    demod_soft_init(&q->demod, q->max_symbols);
    demod_soft_alg_set(&q->demod, APPROX);
    
    sch_init(&q->dl_sch);
    
    q->rnti_is_set = false; 

    // Allocate floats for reception (LLRs)
    q->pdsch_e = malloc(sizeof(float) * q->max_symbols * lte_mod_bits_x_symbol(LTE_QAM64));
    if (!q->pdsch_e) {
      goto clean;
    }
    
    q->pdsch_d = malloc(sizeof(cf_t) * q->max_symbols);
    if (!q->pdsch_d) {
      goto clean;
    }

    for (i = 0; i < q->cell.nof_ports; i++) {
      q->ce[i] = malloc(sizeof(cf_t) * q->max_symbols);
      if (!q->ce[i]) {
        goto clean;
      }
      q->pdsch_x[i] = malloc(sizeof(cf_t) * q->max_symbols);
      if (!q->pdsch_x[i]) {
        goto clean;
      }
      q->pdsch_symbols[i] = malloc(sizeof(cf_t) * q->max_symbols);
      if (!q->pdsch_symbols[i]) {
        goto clean;
      }
    }

    ret = LIBLTE_SUCCESS;
  }
  clean: 
  if (ret == LIBLTE_ERROR) {
    pdsch_free(q);
  }
  return ret;
}

void pdsch_free(pdsch_t *q) {
  int i;

  if (q->pdsch_e) {
    free(q->pdsch_e);
  }
  if (q->pdsch_d) {
    free(q->pdsch_d);
  }
  for (i = 0; i < q->cell.nof_ports; i++) {
    if (q->ce[i]) {
      free(q->ce[i]);
    }
    if (q->pdsch_x[i]) {
      free(q->pdsch_x[i]);
    }
    if (q->pdsch_symbols[i]) {
      free(q->pdsch_symbols[i]);
    }
  }

  for (i = 0; i < NSUBFRAMES_X_FRAME; i++) {
    sequence_free(&q->seq_pdsch[i]);
  }

  for (i = 0; i < 4; i++) {
    modem_table_free(&q->mod[i]);
  }
  demod_soft_free(&q->demod);
  precoding_free(&q->precoding);
  sch_free(&q->dl_sch);

  bzero(q, sizeof(pdsch_t));

}

int pdsch_set_rnti(pdsch_t *q, uint16_t rnti) {
  uint32_t i;
  for (i = 0; i < NSUBFRAMES_X_FRAME; i++) {
    if (sequence_pdsch(&q->seq_pdsch[i], rnti, 0, 2 * i, q->cell.id,
        q->max_symbols * lte_mod_bits_x_symbol(LTE_QAM64))) {
      return LIBLTE_ERROR; 
    }
  }
  q->rnti_is_set = true; 
  q->rnti = rnti; 
  return LIBLTE_SUCCESS;
}


/** Decodes the PDSCH from the received symbols
 */
int pdsch_decode(pdsch_t *q, cf_t *sf_symbols, cf_t *ce[MAX_PORTS], float noise_estimate, uint8_t *data, uint32_t subframe, 
                 harq_t *harq_process, uint32_t rv_idx) 
{

  /* Set pointers for layermapping & precoding */
  uint32_t i, n;
  cf_t *x[MAX_LAYERS];
  uint32_t nof_symbols, nof_bits, nof_bits_e;
  
  if (q                     != NULL &&
      sf_symbols            != NULL &&
      data                  != NULL &&
      subframe              <  10   &&
      harq_process          != NULL)
  {
    
    if (q->rnti_is_set) {
      nof_bits = harq_process->mcs.tbs;
      nof_symbols = harq_process->prb_alloc.re_sf[subframe];
      nof_bits_e = nof_symbols * lte_mod_bits_x_symbol(harq_process->mcs.mod);


      INFO("Decoding PDSCH SF: %d, Mod %s, NofBits: %d, NofSymbols: %d, NofBitsE: %d, rv_idx: %d\n",
          subframe, lte_mod_string(harq_process->mcs.mod), nof_bits, nof_symbols, nof_bits_e, rv_idx);

      /* number of layers equals number of ports */
      for (i = 0; i < q->cell.nof_ports; i++) {
        x[i] = q->pdsch_x[i];
      }
      memset(&x[q->cell.nof_ports], 0, sizeof(cf_t*) * (MAX_LAYERS - q->cell.nof_ports));
        
      /* extract symbols */
      n = pdsch_get(q, sf_symbols, q->pdsch_symbols[0], &harq_process->prb_alloc, subframe);
      if (n != nof_symbols) {
        fprintf(stderr, "Error expecting %d symbols but got %d\n", nof_symbols, n);
        return LIBLTE_ERROR;
      }
      
      /* extract channel estimates */
      for (i = 0; i < q->cell.nof_ports; i++) {
        n = pdsch_get(q, ce[i], q->ce[i], &harq_process->prb_alloc, subframe);
        if (n != nof_symbols) {
          fprintf(stderr, "Error expecting %d symbols but got %d\n", nof_symbols, n);
          return LIBLTE_ERROR;
        }
      }
      
      /* TODO: only diversity is supported */
      if (q->cell.nof_ports == 1) {
        /* no need for layer demapping */
        predecoding_single(&q->precoding, q->pdsch_symbols[0], q->ce[0], q->pdsch_d,
            nof_symbols, noise_estimate);
      } else {
        predecoding_diversity(&q->precoding, q->pdsch_symbols[0], q->ce, x, q->cell.nof_ports,
            nof_symbols, noise_estimate);
        layerdemap_diversity(x, q->pdsch_d, q->cell.nof_ports,
            nof_symbols / q->cell.nof_ports);
      }
      
      /* demodulate symbols 
      * The MAX-log-MAP algorithm used in turbo decoding is unsensitive to SNR estimation, 
      * thus we don't need tot set it in the LLRs normalization
      */
      demod_soft_sigma_set(&q->demod, sqrt(0.5));
      demod_soft_table_set(&q->demod, &q->mod[harq_process->mcs.mod]);
      demod_soft_demodulate(&q->demod, q->pdsch_d, q->pdsch_e, nof_symbols);

      /* descramble */
      scrambling_f_offset(&q->seq_pdsch[subframe], q->pdsch_e, 0, nof_bits_e);

      return dlsch_decode(&q->dl_sch, q->pdsch_e, data, nof_bits, nof_bits_e, harq_process, rv_idx);      
    } else {
      fprintf(stderr, "Must call pdsch_set_rnti() before calling pdsch_decode()\n");
      return LIBLTE_ERROR; 
    }
    
  } else {
    return LIBLTE_ERROR_INVALID_INPUTS;
  }
}


/** Converts the PDSCH data bits to symbols mapped to the slot ready for transmission
 */
int pdsch_encode(pdsch_t *q, uint8_t *data, cf_t *sf_symbols[MAX_PORTS], uint32_t subframe, 
                 harq_t *harq_process, uint32_t rv_idx) 
{
  int i;
  uint32_t nof_symbols, nof_bits, nof_bits_e;
  /* Set pointers for layermapping & precoding */
  cf_t *x[MAX_LAYERS];
   int ret = LIBLTE_ERROR_INVALID_INPUTS; 
   
   if (q             != NULL &&
       data          != NULL &&
       subframe      <  10   &&
       harq_process  != NULL)
  {

    if (q->rnti_is_set) {
      for (i=0;i<q->cell.nof_ports;i++) {
        if (sf_symbols[i] == NULL) {
          return LIBLTE_ERROR_INVALID_INPUTS;
        }
      }
      
      nof_bits = harq_process->mcs.tbs;
      nof_symbols = harq_process->prb_alloc.re_sf[subframe];
      nof_bits_e = nof_symbols * lte_mod_bits_x_symbol(harq_process->mcs.mod);

      if (harq_process->mcs.tbs == 0) {
        return LIBLTE_ERROR_INVALID_INPUTS;      
      }
      
      if (nof_bits > nof_bits_e) {
        fprintf(stderr, "Invalid code rate %.2f\n", (float) nof_bits / nof_bits_e);
        return LIBLTE_ERROR_INVALID_INPUTS;
      }

      if (nof_symbols > q->max_symbols) {
        fprintf(stderr,
            "Error too many RE per subframe (%d). PDSCH configured for %d RE (%d PRB)\n",
            nof_symbols, q->max_symbols, q->cell.nof_prb);
        return LIBLTE_ERROR_INVALID_INPUTS;
      }

      INFO("Encoding PDSCH SF: %d, Mod %s, NofBits: %d, NofSymbols: %d, NofBitsE: %d, rv_idx: %d\n",
          subframe, lte_mod_string(harq_process->mcs.mod), nof_bits, nof_symbols, nof_bits_e, rv_idx);

      /* number of layers equals number of ports */
      for (i = 0; i < q->cell.nof_ports; i++) {
        x[i] = q->pdsch_x[i];
      }
      memset(&x[q->cell.nof_ports], 0, sizeof(cf_t*) * (MAX_LAYERS - q->cell.nof_ports));

      if (dlsch_encode(&q->dl_sch, data, q->pdsch_e, nof_bits, nof_bits_e, harq_process, rv_idx)) {
        fprintf(stderr, "Error encoding TB\n");
        return LIBLTE_ERROR;
      }
      
      scrambling_b_offset(&q->seq_pdsch[subframe], (uint8_t*) q->pdsch_e, 0, nof_bits_e);

      mod_modulate(&q->mod[harq_process->mcs.mod], (uint8_t*) q->pdsch_e, q->pdsch_d, nof_bits_e);

      /* TODO: only diversity supported */
      if (q->cell.nof_ports > 1) {
        layermap_diversity(q->pdsch_d, x, q->cell.nof_ports, nof_symbols);
        precoding_diversity(&q->precoding, x, q->pdsch_symbols, q->cell.nof_ports,
            nof_symbols / q->cell.nof_ports);
      } else {
        memcpy(q->pdsch_symbols[0], q->pdsch_d, nof_symbols * sizeof(cf_t));
      }

      /* mapping to resource elements */
      for (i = 0; i < q->cell.nof_ports; i++) {
        pdsch_put(q, q->pdsch_symbols[i], sf_symbols[i], &harq_process->prb_alloc, subframe);
      }
      ret = LIBLTE_SUCCESS;
    } else {
     fprintf(stderr, "Must call pdsch_set_rnti() to set the encoder/decoder RNTI\n");       
    }
  } 
  return ret; 
}
  