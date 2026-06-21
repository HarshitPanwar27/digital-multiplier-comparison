`timescale 1ns/1ps
// ==========================================================
// Array Multiplier 4x4 (unsigned)
// Straightforward shift-and-add multiplier with a regular,
// structured layout. Simple to implement but has the longest
// critical path among the three architectures compared in
// this project.
// ==========================================================
module array_multiplier_4x4(
    input  wire [3:0] A,
    input  wire [3:0] B,
    output wire [7:0] P
);

    wire [3:0] pp0 = A & {4{B[0]}};
    wire [3:0] pp1 = A & {4{B[1]}};
    wire [3:0] pp2 = A & {4{B[2]}};
    wire [3:0] pp3 = A & {4{B[3]}};

    wire [7:0] term0 = {4'b0000, pp0};          // << 0
    wire [7:0] term1 = {3'b000, pp1, 1'b0};     // << 1
    wire [7:0] term2 = {2'b00, pp2, 2'b00};     // << 2
    wire [7:0] term3 = {1'b0, pp3, 3'b000};     // << 3

    assign P = term0 + term1 + term2 + term3;

endmodule
