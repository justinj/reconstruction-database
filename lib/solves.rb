Solve.add(Solve.new ({
  solver: "Feliks Zemdegs",
  scramble: "B2 U2 R2 D U2 F2 L' D' B2 L2 R' B2 F' D L B' U' B U'",
  solution: "x' y // inspection
D2 R' D F R u' R u' // cross
U' R U' R' y' L U L' // 1st pair
L' U L R U2' R2' U' R // 2nd pair
y' U' R U2' R' U R U' R2' U' R // 3rd / 4th pair
U l' U2 L U L' U l // OLL
U2' R2' F2 R U2' R U2' R' F R U R' U' R' F R2 // PLL",
  time: "8.39"
}))

Solve.add(Solve.new ({
  solver: "Feliks Zemdegs",
  scramble: "D2 F' U2 L2 R' F' D' L' D L' R2 F2 R D L' R2 U F'",
  solution: "y x // inspection
r' U' r' R' D2 R // cross
y' R U' R' // 1st pair
d' U' R U2' R' U R U' R' // 2nd pair
y U2' R' U R2 U' R' // 3rd pair
y U2 R U2' R' U R U R' U R U' R' // 4th pair
U' R2' D' R U2 R' D R U2 R // COLL
R' U' R U' R U R U' R' U R U R2 U' R' U' // EPLL",
  time: "7.95"
}))

Solve.add(Solve.new ({
  solver: "Rob Stuart",
  scramble: "R U R' U'",
  solution: "U R U' R'",
  time: "0.123456789"
}))
