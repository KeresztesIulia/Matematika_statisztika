function index = reindexed_symmetry(index, size)
% nxn-es m�trixban adott indexre megtal�lja a szimmetrikus elemet/indexet

index = index + (size - 1) * (mod(index, size+1)-1);

return

