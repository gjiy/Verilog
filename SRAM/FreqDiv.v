`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 21:46:50
// Design Name: 
// Module Name: FreqDiv
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


module FreqDiv(
	input clk_in,
	output reg clk_out
    );
    parameter N = 100000;
    reg [25:0] count;
    always@(posedge clk_in)
    begin
    	if(count == (N>>1)-1)
    	begin
    		clk_out <= ~clk_out;
    		count <= 0;
    	end
    	else
    	begin
    		count <= count + 1;
    	end
    end
endmodule
