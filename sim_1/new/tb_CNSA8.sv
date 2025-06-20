`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2025 06:20:29 PM
// Design Name: 
// Module Name: tb_CNSA8
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


module tb_CNSA8;

    // DUT Inputs
    logic Cin;
    logic [7:0] operA, operB;

    // DUT Outputs
    logic [7:0] resultOUT;
    logic Cout;

    // Instantiate the DUT
    CNSA8 dut (
        .Cin(Cin),
        .operA(operA),
        .operB(operB),
        .resultOUT(resultOUT),
        .Cout(Cout)
    );

    // Task to run a single test
    task run_test(input logic [7:0] A, 
                  input logic [7:0] B, 
                  input logic Cin_val);
        begin
            operA = A;
            operB = B;
            Cin   = Cin_val;
            #10; // Wait for logic to settle

            $display("A     = %b (%0d)", operA, operA);
            $display("B     = %b (%0d)", operB, operB);
            $display("Cin   = %b", Cin);
            $display("Sum   = %b (%0d)", resultOUT, resultOUT);
            $display("Cout  = %b", Cout);
            $display("-----------------------------");
        end
    endtask

    // Test sequence
    initial begin
        $display("Starting CNSA8 Testbench\n");

        // Test cases
        run_test(8'b00000000, 8'b00000000, 1'b0); // 0 + 0 + 0
        run_test(8'b00000001, 8'b00000001, 1'b0); // 1 + 1 + 0
        run_test(8'b00000001, 8'b00000001, 1'b1); // 1 + 1 + 1
        run_test(8'b11111111, 8'b00000001, 1'b0); // 255 + 1 + 0
        run_test(8'b10101010, 8'b01010101, 1'b0); // Alternating bits
        run_test(8'b11111111, 8'b11111111, 1'b1); // Overflow

        $display("All tests finished.");
        $stop;
    end

endmodule

