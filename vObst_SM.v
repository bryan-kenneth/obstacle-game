`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2018 06:59:00 PM
// Design Name: 
// Module Name: vObst_SM
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


module vObst_SM(
    input clk, bC, bA, drctn, frame, slug, f_clk,
    input [9:0] HQ, VQ, size, TLC, gap_in,
    output start_t, obst, flash
    );
    
    wire [3:0] D, Q;
    wire [9:0] gap;
    
    assign D[0] = bC | Q[0] & ~bA;
    assign D[1] = ~bC & ~(slug & obst) & (Q[0] & bA & ~drctn | Q[1] & ~(gap >= (10'd471 - size)) | Q[2] & (gap == 10'd7));
    assign D[2] = ~bC & ~(slug & obst) & (Q[0] & bA & drctn | Q[1] & (gap >= (10'd471 - size)) | Q[2] & ~(gap == 10'd7));
    assign D[3] = ~bC & (slug & obst | Q[3]);
    FDRE #(.INIT(1'b1)) ff_s0 (.C(clk), .R(1'b0), .CE(1'b1), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) ff_s1 (.C(clk), .R(1'b0), .CE(1'b1), .D(D[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0)) ff_s2 (.C(clk), .R(1'b0), .CE(1'b1), .D(D[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0)) ff_s3 (.C(clk), .R(1'b0), .CE(1'b1), .D(D[3]), .Q(Q[3]));
    assign flash = Q[3];
    assign reset = Q[0];
    assign start_t = Q[1] | Q[2];
    
    countUD10L gap_h(.clk(clk), .up(Q[1]), .dw(Q[2]), .CE(frame | reset), .LD(reset), .D(gap_in), .Q(gap));
        
    assign obst = (~flash | f_clk) & (HQ >= TLC) & (HQ <= (TLC + 10'd7)) &
                      ((Q[0] & (VQ >= 10'd8) & (VQ <= 10'd470)) |
                      ((VQ >= 10'd8) & (VQ < gap)) | ((VQ > (gap + size)) & (VQ <= 10'd470)));
        
endmodule
