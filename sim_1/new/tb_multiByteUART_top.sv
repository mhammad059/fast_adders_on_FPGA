`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/17/2025 04:06:08 PM
// Design Name: 
// Module Name: tb_multiByteUART_top
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


module tb_multiByteUART_top;

    // Testbench Signals
    logic rst;
    logic sys_clk;
    
    logic [1:0] sel_baud;
    logic [7:0] tx_d_in;
    
    logic tx_data;
    logic rx_data; 
    
    logic [7:0] rx_d_out;
    
    logic rx_status;
    logic tx_status;

    logic bclk;
    logic bclkx8;
    
    logic [31:0] ALUout;
    logic [63:0] operAB;
    assign ALUout = operAB[63:32] + operAB[31:0];

    buadRateGen #(.SYS_CLK_FREQ(100_000_000)) brateGen(
        .sys_clk, .rst, .sel_baud, // 0:4800, 1:9600, 2:19200, 3:38400
        .bclk,
        .bclkx8    
        );

    // Instantiate the UART Top Module
    multiByteUART_top uut (
        .rst(rst),
        .sys_clk(sys_clk),
        .sel_baud(sel_baud),
        .rx_data(rx_data),
        .serial_out_TX(ALUout),
        .serial_in_RX(operAB),
        .tx_data(tx_data),
        .rx_status(rx_status),
        .tx_status(tx_status)
    );

    // Generate System Clock (100 MHz -> 10ns period)
    initial begin
        sys_clk = 0;
        forever #5 sys_clk = ~sys_clk;
    end

        // Task to send a byte serially
    task send_byte;
        input [7:0] data;
        integer i;
        begin
            @(posedge bclk);
            
            // Start bit
            rx_data = 0;
            @(posedge bclk);
            // Data bits (LSB first)
            for (i = 0; i < 8; i = i + 1) begin
                rx_data = data[i];
                @(posedge bclk);
            end
            
            // Stop bit
            rx_data = 1;
            @(posedge bclk);
        end
    endtask
    
    // Test sequence
    initial begin
        // Initialize signals
        rst = 1;
        sel_baud = 2'b01;  // 9600 baud
        rx_data = 1;
        
        //  
        #100;

        rst = 0;
        
        // Send test bytes
        send_byte(8'h01);          
        send_byte(8'h00); 
        send_byte(8'h00); 
        send_byte(8'h00); 
        send_byte(8'h01); 
        send_byte(8'h00); 
        send_byte(8'h00); 
        send_byte(8'h00); 
        // wait for tx
        #4500000;

        // Send test bytes
        send_byte(8'h55);          
        send_byte(8'h55); 
        send_byte(8'h55); 
        send_byte(8'h55); 
        send_byte(8'h55); 
        send_byte(8'h55); 
        send_byte(8'h55); 
        send_byte(8'h55); 
        // wait for tx
        #4500000;

        $finish;
    end
    

    // Monitor UART data
    initial begin
        $monitor("Time=%0t | TX Data=%h | RX Data=%h | TX Status=%b | RX Status=%b",
                 $time, tx_d_in, rx_d_out, tx_status, rx_status);
    end

endmodule


