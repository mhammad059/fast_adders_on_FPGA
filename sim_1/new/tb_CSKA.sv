`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2025 06:40:53 PM
// Design Name: 
// Module Name: tb_CSKA
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


module tb_CSKA32;

    // Inputs
    logic [31:0] A, B;
    logic Cin;

    // Outputs
    logic [31:0] Sum;
    logic Cout;

    // Instantiate CSKA32
    CSKA32 uut (
        .Cin(Cin),
        .A(A),
        .B(B),
        .Sum(Sum),
        .Cout(Cout)
    );

    // Task to run a test case
    task run_test(input [31:0] tA, input [31:0] tB, input tCin);
        begin
            A = tA;
            B = tB;
            Cin = tCin;
            #10; // wait for logic to settle
            $display("A = %h, B = %h, Cin = %b => Sum = %h, Cout = %b",
                      A, B, Cin, Sum, Cout);
        end
    endtask

    // Test sequence
    initial begin
        $display("==== CSKA32 Testbench ====");
        
        // Test Cases
        run_test(32'h00000000, 32'h00000000, 1'b0); // 0 + 0
        run_test(32'h00000001, 32'h00000001, 1'b0); // 1 + 1
        run_test(32'hFFFFFFFF, 32'h00000001, 1'b0); // Max + 1
        run_test(32'h12345678, 32'h87654321, 1'b0); // Random + Random
        run_test(32'hAAAAAAAA, 32'h55555555, 1'b1); // Alternating pattern + Cin
        run_test(32'hFFFFFFFF, 32'hFFFFFFFF, 1'b1); // Max + Max + Cin
        
        $finish;
    end

endmodule
