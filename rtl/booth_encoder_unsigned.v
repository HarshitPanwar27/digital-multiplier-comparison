`timescale 1ns/1ps
// ==========================================================
// Booth Encoder (Radix-4, unsigned A, 2's complement partial
// product output)
//
// Examines a 3-bit group of the multiplier (current 2 bits +
// 1 overlap bit from the previous group) and selects the
// corresponding operation on the multiplicand A:
//
//   000, 111 -> 0
//   001, 010 -> +A
//   011      -> +2A
//   100      -> -2A
//   101, 110 -> -A
// ==========================================================
module booth_encoder_unsigned(
    input  [2:0] grp,
    input  [3:0] A,        // 4-bit UNSIGNED multiplicand
    output reg  [5:0] pp    // 6-bit 2's complement partial product
);

    reg [5:0] R;

    always @(*) begin
        // zero-extend A to 6 bits once
        R = {2'b00, A};
        case (grp)
            3'b000,
            3'b111: pp = 6'd0;             // 0
            3'b001,
            3'b010: pp = R;                // +A
            3'b011: pp = R << 1;           // +2A
            3'b100: pp = 6'd0 - (R << 1);  // -2A
            3'b101,
            3'b110: pp = 6'd0 - R;         // -A
            default: pp = 6'd0;
        endcase
    end

endmodule
