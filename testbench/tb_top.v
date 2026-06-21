`timescale 1ns/1ps
// ==========================================================
// Top-level Testbench
//
// Instantiates all three multiplier architectures with the
// same A and B inputs, sweeps 16 test vectors, and checks the
// Booth multiplier's output against the expected A*B result
// (Array and Wallace results are displayed alongside for
// visual cross-checking in the simulator waveform/log).
// ==========================================================
module tb_top;

    reg  [3:0] A;
    reg  [3:0] B;

    wire [7:0] P_array;
    wire [7:0] P_booth;
    wire [7:0] P_wallace;

    array_multiplier_4x4   u_array   (.A(A), .B(B), .P(P_array));
    booth_multiplier_4x4   u_booth   (.A(A), .B(B), .P(P_booth));
    wallace_multiplier_4x4 u_wallace (.A(A), .B(B), .P(P_wallace));

    integer i;
    integer errors;

    initial begin
        $display("=== Testbench started ===");
        errors = 0;

        for (i = 0; i < 16; i = i + 1) begin
            A = i;
            B = 15 - i;  // sweep with varied operand combinations
            #10;

            $display("A=%0d B=%0d ARRAY=%0d BOOTH=%0d WALLACE=%0d",
                      A, B, P_array, P_booth, P_wallace);

            if (P_booth !== (A * B)) begin
                $display("ERROR BOOTH: A=%0d B=%0d P=%0d expected=%0d",
                          A, B, P_booth, A * B);
                errors = errors + 1;
            end
        end

        if (errors == 0)
            $display("**** ALL TESTS PASSED - NO ERRORS ****");
        else
            $display("**** TESTS FINISHED WITH %0d ERRORS ****", errors);

        $finish;
    end

endmodule
