`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2025 07:51:27 PM
// Design Name: 
// Module Name: tb_CLA32
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


module tb_CLA32;
    // Inputs
    logic Cin;
    logic [31:0] operA;
    logic [31:0] operB;

    // Outputs
    logic [31:0] resultOUT;
    logic Cout;

    // Instantiate the RCA32 module
    CLA32 uut (
        .Cin(Cin),
        .operA(operA),
        .operB(operB),
        .resultOUT(resultOUT),
        .Cout(Cout)
    );

    // Task for applying test vectors
    task run_test(input logic [31:0] a, input logic [31:0] b, input logic cin);
        begin
            operA = a;
            operB = b;
            Cin = cin;
            #10; // Wait for propagation

            $display("A = 0x%8h, B = 0x%8h, Cin = %b --> Result = 0x%8h, Cout = %b", 
                     a, b, cin, resultOUT, Cout);
        end
    endtask

    // Test procedure
    initial begin
        $display("Starting CLA32 testbench...");

        // Test vectors
        run_test(32'h00000000, 32'h00000000, 0);
        run_test(32'hFFFFFFFF, 32'h00000001, 0);
        run_test(32'hAAAAAAAA, 32'h55555555, 0);
        run_test(32'h12345678, 32'h87654321, 0);
        run_test(32'hFFFFFFFF, 32'hFFFFFFFF, 1);
        run_test(32'h80000000, 32'h80000000, 0);

        $display("Testbench completed.");
        $stop;
    end

endmodule