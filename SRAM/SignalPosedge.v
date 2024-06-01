`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 23:18:18
// Design Name: 
// Module Name: SignalPosedge
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


module SignalPosedge(
	input clk_in,
	input sig,
	output sig_pos
    );
    reg sig_buf;
    always@(posedge clk_in)
    begin
    	sig_buf <= sig;
    end
    assign sig_pos = sig&(!sig_buf);
endmodule
