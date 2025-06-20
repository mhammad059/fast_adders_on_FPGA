`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2025 08:39:37 PM
// Design Name: 
// Module Name: tb_CSA4bit6oper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_CSA4bit6oper;

    // Inputs
    logic [3:0] operA, operB, operC, operD, operE, operF;

    // Output
    logic [6:0] result;

    // DUT
    CSA_4bit6oper dut (
        .operA(operA),
        .operB(operB),
        .operC(operC),
        .operD(operD),
        .operE(operE),
        .operF(operF),
        .result(result)
    );

    // Expected value calculator
    function [6:0] expected_sum(
        input [3:0] a, b, c, d, e, f
    );
        return a + b + c + d + e + f;
    endfunction

    // Test procedure
    initial begin
        $display("Starting CSA 4-bit 6-oper testbench...");
        $display("----------------------------------------");

        // Test vectors
        repeat (10) begin
            // Random 4-bit values
            operA = $urandom_range(0, 15);
            operB = $urandom_range(0, 15);
            operC = $urandom_range(0, 15);
            operD = $urandom_range(0, 15);
            operE = $urandom_range(0, 15);
            operF = $urandom_range(0, 15);

            // Wait for outputs to settle
            #1;

            $display("A = %d, B = %d, C = %d, D = %d, E = %d, F = %d --> Result = %d, Expected = %d",
                operA, operB, operC, operD, operE, operF,
                result, expected_sum(operA, operB, operC, operD, operE, operF)
            );
        end

        $display("----------------------------------------");
        $display("Testbench completed.");
        $finish;
    end

endmodule


