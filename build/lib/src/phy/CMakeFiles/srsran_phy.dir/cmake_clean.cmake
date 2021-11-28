file(REMOVE_RECURSE
  "libsrsran_phy.pdb"
  "libsrsran_phy.a"
)

# Per-language clean rules from dependency scanning.
foreach(lang C CXX)
  include(CMakeFiles/srsran_phy.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
