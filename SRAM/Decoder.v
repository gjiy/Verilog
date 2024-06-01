`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 23:31:25
// Design Name: 
// Module Name: Decoder
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


module Decoder(
	input [3:0] num,
    output reg [6:0] code
    );
    always@(*)
        case(num)
            4'd0:code[6:0]=7'b0111111;
            4'd1:code[6:0]=7'b0000110;
            4'd2:code[6:0]=7'b1011011;
            4'd3:code[6:0]=7'b1001111;
            4'd4:code[6:0]=7'b1100110;
            4'd5:code[6:0]=7'b1101101;
            4'd6:code[6:0]=7'b1111101;
            4'd7:code[6:0]=7'b0000111;
            4'd8:code[6:0]=7'b1111111;
            4'd9:code[6:0]=7'b1101111;
            4'd10:code[6:0]=7'b1110111;
            4'd11:code[6:0]=7'b1111100;
            4'd12:code[6:0]=7'b0111001;
            4'd13:code[6:0]=7'b1011110;
            4'd14:code[6:0]=7'b1111001;
            4'd15:code[6:0]=7'b1110001;
            default:code[6:0]=7'b0000000;
        endcase
endmodule
