`timescale 1ns/1ps
// ==========================================================
// Booth Multiplier 4x4 (Radix-4, full implementation, 3 groups)
//
// Works for UNSIGNED A and B in the range 0..15.
// Reduces 4 partial products (as in the array multiplier) down
// to 3 Booth-encoded partial products, lowering the number of
// addition stages required.
//
// Depends on: booth_encoder_unsigned.v
// ==========================================================
module booth_multiplier_4x4(
    input  [3:0] A,
    input  [3:0] B,
    output [7:0] P
);

    // Extend B by one 0 on the MSB side for unsigned Booth
    // Extended multiplier bits: X[4:0] = {0, B[3], B[2], B[1], B[0]}
    wire [4:0] X = {1'b0, B};

    // Radix-4 Booth groups (3 groups for a 4-bit B)
    //   Group 0: (X[1], X[0], 0)
    //   Group 1: (X[3], X[2], X[1])
    //   Group 2: (X[4], X[4], X[3])  -- sign-extended top group
    wire [2:0] grp0 = {X[1], X[0], 1'b0};
    wire [2:0] grp1 = {X[3], X[2], X[1]};
    wire [2:0] grp2 = {X[4], X[4], X[3]};

    wire signed [5:0] pp0, pp1, pp2;

    booth_encoder_unsigned u0 (grp0, A, pp0);
    booth_encoder_unsigned u1 (grp1, A, pp1);
    booth_encoder_unsigned u2 (grp2, A, pp2);

    // Sign-extend each partial product to 8 bits and shift into place
    wire signed [7:0] s0 = {{2{pp0[5]}}, pp0};            // << 0
    wire signed [7:0] s1 = ({{2{pp1[5]}}, pp1}) <<< 2;    // << 2
    wire signed [7:0] s2 = ({{2{pp2[5]}}, pp2}) <<< 4;    // << 4

    assign P = s0 + s1 + s2;

endmodule
