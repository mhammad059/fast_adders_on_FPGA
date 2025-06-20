`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2025 02:43:33 PM
// Design Name: 
// Module Name: tb_FA
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


module tb_FA;

    logic Cin;
    logic A;
    logic B;
    logic sum;
    logic Cout;
    
    FA full_adder(.*);

    initial begin
        A = 0; B = 0; Cin = 0; #5;
        A = 0; B = 0; Cin = 1; #5;
        A = 0; B = 1; Cin = 0; #5;
        A = 0; B = 1; Cin = 1; #5;
        A = 1; B = 0; Cin = 0; #5;
        A = 1; B = 0; Cin = 1; #5;
        A = 1; B = 1; Cin = 0; #5;
        A = 1; B = 1; Cin = 1; #5;
        $finish;
    end
    // Monitor UART data
    initial begin
        $monitor("Sum=%h | Cout=%h", sum, Cout);
    end
endmodule
