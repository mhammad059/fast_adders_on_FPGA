`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2025 02:47:00 PM
// Design Name: 
// Module Name: CLA_logic
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


module CLA_logic #(parameter N = 4) (
    input logic Cin,
    input logic [N-1:0] p,
    input logic [N-1:0] g,
    output logic [N-1:0] Couts,
    output logic Pout,
    output logic Gout
    );


    // integer i, j;

    // generate 
    //     always_comb begin
    //         // Carry-in signals
    //         Couts[0] = Cin;
    //         for (i = 1; i < N; i++) begin
    //             Couts[i] = g[i-1];
    //             for (j = i-2; j >= 0; j--) begin
    //                 Couts[i] |= &p[i-1:j+1] & g[j];
    //             end
    //             Couts[i] |= &p[i-1:0] & Cin;
    //         end

    //         // Group Propagate: Pout = AND of all p[i]
    //         Pout = &p;

    //         // Group Generate: Gout = g[N-1] + p[N-1]g[N-2] + ... + p[N-1]...p[0]
    //         Gout = g[N-1];
    //         for (i = N-2; i >= 0; i--) begin
    //             Gout |= &p[N-1:i+1] & g[i];
    //         end
    //     end
    // endgenerate


    assign Couts[2] = g[2] |
                    (p[2]&g[1]) |
                    (p[2]&p[1]&g[0]) |
                    (p[2]&p[1]&p[0]&Cin);

    assign Couts[1] = g[1] |
                    (p[1]&g[0]) |
                    (p[1]&p[0]&Cin);

    assign Couts[0] = g[0] |
                    (p[0]&Cin);

    assign Gout =   g[3] |
                   (p[3]&g[2]) |
                   (p[3]&p[2]&g[1]) |
                   (p[3]&p[2]&p[1]&g[0]);

    assign Pout = &p;

    assign Couts[3] = Gout | (Pout & Cin); 
 

endmodule
