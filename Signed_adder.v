`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2023 11:54:33 AM
// Design Name: 
// Module Name: Signed_adder
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


module Signed_adder(
    input [4:0] A,
    input [4:0] B,
    input Button,
    input CLK,
    output [3:0] an,
    output [7:0] seg
    );
    
    wire [4:0]sum, b_twos; 
    
    nb_twos_comp twos_b(
    .a (B),
    .a_min(b_twos)
    );
     
    mux_2t1_nb mux_b(
    .D0 (B),
    .D1 (b_twos),
    .SEL (Button),
    .D_OUT(b_out)
    );
    
    rca_nb five_rca(
    .a (A),
    .B (b_out),
    .cin(0),
    .sum(sum),
    .co (co)
    
    
    );
    
    nb_twos_comp twos_sum(
    .a (sum),
    .a_min(sum_twos)
    );
    
     mux_2t1_nb mux_sum(
    .D0 (sum),
    .D1 (sum_twos),
    .SEL (sum[4]),
    .D_OUT(sum_out)
    );
    
    rc_valid_chk valid_check(
    .a_sb (A),
	.b_sb (B),
	.sum_sb (sum),
    .valid (valid)
    
    );
    
    univ_sseg my_univ_sseg (
     .cnt1    ({9'b000000000,sum_out}), 
     .cnt2    (0), 
     .valid   (valid), 
     .dp_en   (0), 
     .dp_sel  (0), 
     .mod_sel (2'b00), 
     .sign    (sum[4]), 
     .clk     (CLK), 
     .ssegs   (segs), 
     .disp_en (an)    ); 
    
       
endmodule


 
 
 
 