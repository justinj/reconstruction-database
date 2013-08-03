Solve.add(Solve.new ({ solver: "Feliks Zemdegs",
  scramble: "B2 U2 R2 D U2 F2 L' D' B2 L2 R' B2 F' D L B' U' B U'",
  solution: "x' y // inspection
D2 R' D F R u' R u' // cross
U' R U' R' y' L U L' // 1st pair
L' U L R U2' R2' U' R // 2nd pair
y' U' R U2' R' U R U' R2' U' R // 3rd / 4th pair
U l' U2 L U L' U l // OLL
U2' R2' F2 R U2' R U2' R' F R U R' U' R' F R2 // PLL",
  time: "8.39",
  competition: "WC2013",
  youtube: "m250xEA3mM4",
  puzzle: "3x3x3"
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
  time: "7.95",
  competition: "WC2013",
  youtube: "m250xEA3mM4",
  puzzle: "3x3x3"
}))

Solve.add(Solve.new ({
  solver: "Rob Stuart",
  scramble: "R U R' U'",
  solution: "U R U' R'",
  time: "0.123456789",
  puzzle: "3x3x3"
}))

Solve.add(Solve.new ({
  solver: "Kristopher De Asis",
  scramble: "L2 B2 U' f' F2 b2 U u2 l f' R' u F2 D2
  u' f d' l' F2 R D f2 U d r' U L2 F u f
  F2 d b' u' L' U2 L u D B u' F U2 u2 D2
  f R' D' U B2 U' f2 B d U u2 b B' l' r",
  solution: "y' // inspection
  
  // centres
  U 2r U 3l' U' 3r' // white 2x2x3
(z x') 2r U (y x') 2r' F' 2r' // white
3U' 2l' U' 2l y 3l' U 3l // yellow 2x2x3
z' 3R U2 3R' U2 (y x') 2l' U2 2l // yellow
                 (z' x') F U' 2r U' 2r' // orange 2x2x3
x' U 3R U 3l 2l // orange
x' U2 3l2' U2 3l2 // blue 2x2x3
D' U 2l' U 2l' U2 2l2 // blue
x U 2l U 2l' // green 2x2x3
2r' U' 2r U 2r' U2 z' // green / red

// edges
y' U L' U L 3U // RG
y' U2 R U' R' 3u 2u // YG
U2 R U' R' 2u2 U' L' U L 3U' // WG
U' R U' R' 2u R U 4l' U R' U' 4l 3U // RB
U2 R U' R' z2' 2d U' L' U L 3u' // YB
L' U L 3d' // YR
y L' U L 2u 2d2 // GO
L' U L 2u' // WO
L' U' L 2u' // fix centres
R' U R 3U // WB
L' U L 3U' L U' L' 2d // YO
R U' R' 2u' R U 4l' U R' U' 4l 3U' // OB / WR

// 3x3x3
L (y x) L U x' R' D R2 // white cross
R U2 R' U L U L' // wOB
y' U2 R' U' R // wGR
U R U' R' // wRB
y U2' R' U2 R U' R' U R // wGO
U2' R U R' U R U' R' U' x R' U R U' x' // OLL
U2 R' U' R U' R' F' R U R' U' R' F R U2 R // PLL",
  time: "49.15",
  youtube: "GDWPIfMfja8",
  puzzle: "5x5x5"
}))
