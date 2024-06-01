`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 23:34:16
// Design Name: 
// Module Name: Disp
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


module Disp(
	input clk_sc,
	input en,
	input flag,
	input [27:0] code,
	output reg [3:0] seg_cs_pin,
	output reg [6:0] seg_data_1_pin
    );
    parameter [1:0] STATE_A = 2'b00;
    parameter [1:0] STATE_B = 2'b01;
    parameter [1:0] STATE_C = 2'b10;
    parameter [1:0] STATE_D = 2'b11;
    reg [1:0] current_state, next_state;
    always@(*)
    case(current_state)
    	STATE_A:next_state = STATE_B;
    	STATE_B:next_state = STATE_C;
    	STATE_C:next_state = STATE_D;
    	STATE_D:next_state = STATE_A;
    endcase
    always@(posedge clk_sc)
    begin
    	current_state <= next_state;
    end
    always@(posedge clk_sc)
	if(!en)
		begin
			if(!flag)
			begin
				seg_cs_pin <= 4'b0000;
				seg_data_1_pin[6:0] <= 7'b0000000;
			end
			else
			case(next_state)
				STATE_A:
				begin
					seg_cs_pin <= 4'b0100;
					seg_data_1_pin[6:0] <= 7'b1011100;
				end
				STATE_B:
				begin
					seg_cs_pin <= 4'b1000;
					seg_data_1_pin[6:0] <= 7'b1110101;
				end
				STATE_C:
				begin
					seg_cs_pin <= 4'b0100;
					seg_data_1_pin[6:0] <= 7'b1011100;
				end
				STATE_D:
				begin
					seg_cs_pin <= 4'b1000;
					seg_data_1_pin[6:0] <= 7'b1110101;
				end
			endcase
		end
	else
	case(next_state)
		STATE_A:
		begin
			seg_cs_pin <= 4'b0001;
			seg_data_1_pin[6:0] <= code[6:0];
		end
		STATE_B:
		begin
			seg_cs_pin <= 4'b0010;
			seg_data_1_pin[6:0] <= code[13:7];
		end
		STATE_C:
		begin
			seg_cs_pin <= 4'b0100;
			seg_data_1_pin[6:0] <= code[20:14];
		end
		STATE_D:
		begin
			seg_cs_pin <= 4'b1000;
			seg_data_1_pin[6:0] <= code[27:21];
		end
	endcase
endmodule
