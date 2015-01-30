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

#include <math.h>
#include <string.h>
#include <strings.h>
#include <stdlib.h>
#include <complex.h>

#include "liblte/phy/common/phy_common.h"
#include "liblte/phy/ch_estimation/refsignal_ul.h"
#include "liblte/phy/utils/vector.h"
#include "liblte/phy/utils/debug.h"
#include "liblte/phy/common/sequence.h"

#include "ul_rs_tables.h"

// n_drms_2 table 5.5.2.1.1-1 from 36.211
uint32_t n_drms_2[8] = { 0, 6, 3, 4, 2, 8, 10, 9 };

// n_drms_1 table 5.5.2.1.1-2 from 36.211
uint32_t n_drms_1[8] = { 0, 2, 3, 4, 6, 8, 9, 10 };


/** Computes n_prs values used to compute alpha as defined in 5.5.2.1.1 of 36.211 */
static int generate_n_prs(refsignal_ul_t * q) {
  /* Calculate n_prs */
  uint32_t c_init; 
  
  sequence_t seq; 
  bzero(&seq, sizeof(sequence_t));
    
  for (uint32_t delta_ss=0;delta_ss<NOF_DELTA_SS;delta_ss++) {
    c_init = ((q->cell.id / 30) << 5) + (((q->cell.id % 30) + delta_ss) % 30);
    if (sequence_LTE_pr(&seq, 8 * CP_NSYMB(q->cell.cp) * 20, c_init)) {
      return LIBLTE_ERROR;
    }
    for (uint32_t ns=0;ns<NSLOTS_X_FRAME;ns++) {  
      uint32_t n_prs = 0;
      for (int i = 0; i < 8; i++) {
        n_prs += (seq.c[8 * CP_NSYMB(q->cell.cp) * ns + i] << i);
      }
      q->n_prs_pusch[delta_ss][ns] = n_prs;
    }
  }

  sequence_free(&seq);
  return LIBLTE_SUCCESS; 
}

/** Computes sequence-group pattern f_gh according to 5.5.1.3 of 36.211 */
static int generate_group_hopping_f_gh(refsignal_ul_t *q) {
  sequence_t seq; 
  bzero(&seq, sizeof(sequence_t));
  
  if (sequence_LTE_pr(&seq, 160, q->cell.id / 30)) {
    return LIBLTE_ERROR;
  }
  
  for (uint32_t ns=0;ns<NSLOTS_X_FRAME;ns++) {
    uint32_t f_gh = 0;
    for (int i = 0; i < 8; i++) {
      f_gh += (((uint32_t) seq.c[8 * ns + i]) << i);
    }
    q->f_gh[ns] = f_gh;    
  }

  sequence_free(&seq);
  return LIBLTE_SUCCESS;
}

static int generate_sequence_hopping_v(refsignal_ul_t *q) {
  sequence_t seq; 
  bzero(&seq, sizeof(sequence_t));
  
  for (uint32_t ns=0;ns<NSLOTS_X_FRAME;ns++) {
    for (uint32_t delta_ss=0;delta_ss<NOF_DELTA_SS;delta_ss++) {
      if (sequence_LTE_pr(&seq, 20, ((q->cell.id / 30) << 5) + ((q->cell.id%30)+delta_ss)%30)) {
        return LIBLTE_ERROR;
      }
      q->v_pusch[ns][delta_ss] = seq.c[ns];    
    }
  }
  sequence_free(&seq);
  return LIBLTE_SUCCESS;
}

/** Initializes refsignal_ul_t object according to 3GPP 36.211 5.5
 *
 */
int refsignal_ul_init(refsignal_ul_t * q, lte_cell_t cell)
{

  int ret = LIBLTE_ERROR_INVALID_INPUTS;

  if (q != NULL && lte_cell_isvalid(&cell)) {

    bzero(q, sizeof(refsignal_ul_t));
    q->cell = cell; 
    
    // Allocate temporal buffer for computing signal argument
    q->tmp_arg = vec_malloc(RE_X_RB * q->cell.nof_prb * sizeof(cf_t)); 
    if (!q->tmp_arg) {
      perror("malloc");
      goto free_and_exit;
    }
    
    // Precompute n_prs
    if (generate_n_prs(q)) {
      goto free_and_exit;
    }
    
    // Precompute group hopping values u. 
    if (generate_group_hopping_f_gh(q)) {
      goto free_and_exit;
    }
    
    // Precompute sequence hopping values v. Uses f_ss_pusch
    if (generate_sequence_hopping_v(q)) {
      goto free_and_exit;
    }

    ret = LIBLTE_SUCCESS;
  }
free_and_exit:
  if (ret == LIBLTE_ERROR) {
    refsignal_ul_free(q);
  }
  return ret;
}

void refsignal_ul_free(refsignal_ul_t * q) {
  if (q->tmp_arg) {
    free(q->tmp_arg);
  }
  bzero(q, sizeof(refsignal_ul_t));
}


uint32_t largest_prime_lower_than(uint32_t x) {
  /* get largest prime n_zc<len */
  for (uint32_t i = NOF_PRIME_NUMBERS - 1; i > 0; i--) {
    if (prime_numbers[i] < x) {
      return prime_numbers[i];
    }
  }
  return 0;
}

static void arg_r_uv_1prb(float *arg, uint32_t u) {
  for (int i = 0; i < RE_X_RB; i++) {
    arg[i] = phi_M_sc_12[u][i] * M_PI / 4;
  }
}

static void arg_r_uv_2prb(float *arg, uint32_t u) {
  for (int i = 0; i < 2*RE_X_RB; i++) {
    arg[i] = phi_M_sc_24[u][i] * M_PI / 4;
  }  
}

static uint32_t get_q(uint32_t u, uint32_t v, uint32_t N_sz) {
  float q;
  float q_hat;
  float n_sz = (float) N_sz;
  
  q_hat = n_sz *(u + 1) / 31;
  if ((((uint32_t) (2 * q_hat)) % 2) == 0) {
    q = q_hat + 0.5 + v;
  } else {
    q = q_hat + 0.5 - v;
  }
  return (uint32_t) q; 
}

static void arg_r_uv_mprb(float *arg, uint32_t M_sc, uint32_t u, uint32_t v) {

  uint32_t N_sz = largest_prime_lower_than(M_sc);
  float q = get_q(u,v,N_sz);
  float n_sz = (float) N_sz;
  
  for (uint32_t i = 0; i < M_sc; i++) {
    float m = (float) (i%N_sz);
    arg[i] =  -M_PI * q * m * (m + 1) / n_sz;
  }
}

/* Computes argument of r_u_v signal */
static void compute_pusch_r_uv_arg(refsignal_ul_t *q, refsignal_drms_pusch_cfg_t *cfg, uint32_t u, uint32_t v) {
  if (cfg->nof_prb == 1) {
    arg_r_uv_1prb(q->tmp_arg, u);
  } else if (cfg->nof_prb == 2) {
    arg_r_uv_2prb(q->tmp_arg, u);
  } else {
    arg_r_uv_mprb(q->tmp_arg, RE_X_RB*cfg->nof_prb, u, v);
  }
}

/* Calculates alpha according to 5.5.2.1.1 of 36.211 */
static float get_alpha(refsignal_ul_t *q, refsignal_ul_cfg_t *cfg, uint32_t ns) {
  uint32_t n_drms_2_val = 0; 
  if (cfg->en_drms_2) {
    n_drms_2_val = n_drms_2[cfg->cyclic_shift_for_drms];
  }
  uint32_t n_cs = (n_drms_1[cfg->cyclic_shift] + n_drms_2_val + q->n_prs_pusch[cfg->delta_ss][ns]) % 12;
  
  return 2 * M_PI * (n_cs) / 12;

}

bool refsignal_drms_pusch_cfg_isvalid(refsignal_ul_t *q, refsignal_drms_pusch_cfg_t *cfg) {
  if (cfg->common.cyclic_shift          < NOF_CSHIFT   && 
      cfg->common.cyclic_shift_for_drms < NOF_CSHIFT   &&
      cfg->common.delta_ss              < NOF_DELTA_SS &&
      cfg->nof_prb                      < q->cell.nof_prb) {
    return true; 
  } else {
    return false;
  }
}


/* Generate DRMS for PUSCH signal according to 5.5.2.1 of 36.211 */
int refsignal_dmrs_pusch_gen(refsignal_ul_t *q, refsignal_drms_pusch_cfg_t *cfg, uint32_t ns, cf_t *r_pusch) {

  int ret = LIBLTE_ERROR_INVALID_INPUTS;
  if (refsignal_drms_pusch_cfg_isvalid(q, cfg)) {
    ret = LIBLTE_ERROR;
    
    // Get group hopping number u 
    uint32_t f_gh=0; 
    if (cfg->hopping_method == HOPPING_GROUP) {
      f_gh = q->f_gh[ns];
    }
    uint32_t u = (f_gh + (q->cell.id%30)+cfg->common.delta_ss)%30;
    
    
    // Get sequence hopping number v 
    uint32_t v = 0; 
    if (cfg->nof_prb >= 6 && cfg->hopping_method == HOPPING_SEQUENCE) {
      v = q->v_pusch[ns][cfg->common.delta_ss];
    }

    // Compute signal argument 
    compute_pusch_r_uv_arg(q, cfg, u, v);

    // Add cyclic prefix alpha
    float alpha = get_alpha(q, &cfg->common, ns);

    if (verbose == VERBOSE_DEBUG) {
      uint32_t N_sz = largest_prime_lower_than(cfg->nof_prb*RE_X_RB);
      DEBUG("Generating PUSCH DRMS sequence with parameters:\n",0);
      DEBUG("\tu: %d, v: %d, alpha: %f, N_sc: %d, root q: %d\n", 
            u, v, alpha, N_sz, get_q(u,v,N_sz));
    }

    vec_fprint_f(stdout, q->tmp_arg, RE_X_RB*cfg->nof_prb);
    
    // Do complex exponential and adjust amplitude
    for (int i=0;i<RE_X_RB*cfg->nof_prb;i++) {
      r_pusch[i] = cfg->beta_pusch * cexpf(I*(q->tmp_arg[i] + alpha*i));
    }
      vec_fprint_c(stdout, r_pusch, RE_X_RB*cfg->nof_prb);
    ret = 0; 
  }
  return ret; 
}

void refsignal_dmrs_pucch_gen(refsignal_ul_t *q, refsignal_drms_pucch_cfg_t *cfg, uint32_t ns, cf_t *r_pucch) {
  
}

void refsignal_srs_gen(refsignal_ul_t *q, refsignal_srs_cfg_t *cfg, uint32_t ns, cf_t *r_srs) {
  
}
