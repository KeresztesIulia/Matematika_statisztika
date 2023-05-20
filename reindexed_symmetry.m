function index = reindexed_symmetry(index, size)
% nxn-es mátrixban adott indexre megtalálja a szimmetrikus elemet/indexet

index = index + (size - 1) * (mod(index, size+1)-1);

return

