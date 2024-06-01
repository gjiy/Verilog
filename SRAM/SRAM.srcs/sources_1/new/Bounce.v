`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 21:15:55
// Design Name: 
// Module Name: Bounce
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


module Bounce(
	input clk_in,
	input sig_in,
	output reg sig_out
    );
    parameter MAX = 2;
    reg [3:0] cnt;
    reg current_state, next_state, sig_buf;
    always@(*)
    case(current_state)
    	0:
    	begin
    		if(sig_in != sig_buf)
    		begin
    			next_state = 1;
    		end
    		if(sig_in == sig_buf)
    		begin
    			next_state = 0;
    		end
    	end
    	1:
    	begin
    		if(cnt == MAX)
    		begin
    			next_state = 0;
    		end
    		if(cnt < MAX)
    		begin
    			next_state = 1;
    		end
    	end
    endcase
    always@(posedge clk_in)
    begin
    	current_state <= next_state;
    	cnt <= cnt + 1;
    end
    always@(posedge clk_in)
    case(next_state)
    	0:cnt <= 0;
    	1:
    	begin
    		if(sig_in != sig_buf)
    		begin
    			sig_out <= sig_in;
    			sig_buf <= sig_in;
    		end
    	end
    endcase
endmodule
