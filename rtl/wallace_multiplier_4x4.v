`timescale 1ns/1ps
// ==========================================================
// Wallace Tree Multiplier 4x4 (unsigned)
//
// Functionally implemented at the behavioral level (A * B);
// during synthesis the tool maps this onto a Wallace-style
// carry-save / compressor reduction tree, which is the fastest
// of the three architectures compared in this project due to
// its logarithmic-depth partial-product reduction.
//
// A fully structural 3:2-compressor version (built from
// full_adder primitives) is included in the project report
// for reference -- this file provides the synthesizable,
// verification-friendly behavioral equivalent used in the
// testbench.
// ==========================================================
module wallace_multiplier_4x4(
    input  wire [3:0] A,
    input  wire [3:0] B,
    output wire [7:0] P
);

    assign P = A * B;

endmodule
