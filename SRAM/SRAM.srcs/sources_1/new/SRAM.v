`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/31 00:22:23
// Design Name: 
// Module Name: SRAM
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


module SRAM(
    input sys_clk_in,
    input [15:0] sw_pin,
    input is_we_btn,
    output [3:0] seg_cs_pin,
    output [6:0] seg_data_1_pin,
    output sram_we_n,
    output [15:0] sram_addr,
    output sram_ub_n,
    output sram_lb_n,
    output sram_ce_n,
    output sram_oe_n,
    inout [15:0] sram_data
    );
    wire clk_sc, is_we_pos, clk_bounce, is_we;
    reg flag;
    reg [1:0] current_state = 2'd1, next_state;
    reg [15:0] sram_wr_data, sram_rd_data, sram_wr_addr, sram_rd_addr;
    wire [27:0] code;
    FreqDiv #(100000) FreqDiv1(.clk_in(sys_clk_in), .clk_out(clk_sc));
    FreqDiv #(5000000) FreqDiv2(.clk_in(sys_clk_in), .clk_out(clk_bounce));
    FreqDiv #(5000) FreqDiv3(.clk_in(sys_clk_in), .clk_out(clk));
    assign sram_ce_n = 0;
    assign sram_oe_n = 0;
    assign sram_ub_n = 0;
    assign sram_lb_n = 0;
    assign sram_we_n = !is_we;
    assign sram_data = (is_we) ? sram_wr_data : 16'bZZZZ_ZZZZ_ZZZZ_ZZZZ;
    assign sram_addr = (is_we) ? sram_wr_addr : sram_rd_addr;
    SignalPosedge signal_posedge1(.clk_in(sys_clk_in), .sig(is_we), .sig_pos(is_we_pos));
    Bounce #(2) Bounce1(.clk_in(clk_bounce), .sig_in(is_we_btn), .sig_out(is_we));

    always@(*)
    case (current_state)
        2'd0: next_state = is_we ? 1 : 2;
        2'd1: next_state = (sram_wr_addr < 16'b1111_1111_1111_1111) ? (is_we ? 0 : 2) : 2;
        2'd2: next_state = (sram_wr_addr < 16'b1111_1111_1111_1111) ? (is_we ? 1 : 2) : 2;
    endcase

    always@(posedge sys_clk_in)
    begin
        current_state <= next_state;
    end

    always@(posedge sys_clk_in)
    case (next_state)
        2'd0: 
        begin
            sram_wr_addr <= sram_wr_addr + 1;
        end
        2'd1:
        begin
            flag <= 0;
            sram_wr_data <= sw_pin + sram_wr_addr;
        end
        2'd2: 
        begin
            flag <= 1;
            if(is_we_pos)
                sram_wr_addr <= 16'b0000_0000_0000_0000;
            sram_rd_addr <= sw_pin;
        end
    endcase

    Decoder_all Decoder_all1(.inData(sram_data), .outData(code));
    Disp Disp1(.flag(flag), .clk_sc(clk_sc), .en(!is_we), .code(code), .seg_cs_pin(seg_cs_pin), .seg_data_1_pin(seg_data_1_pin));
endmodule
