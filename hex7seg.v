`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2018 09:26:39 PM
// Design Name: 
// Module Name: hex7seg
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


module hex7seg(
    input [3:0] n,
    input e,
    output [6:0] seg
    );
    
    m8_le CA(.in({1'b0, 1'b0, n[3], ~n[3], n[3], 1'b0, ~n[3], 1'b0}), .sel({n[2], n[1], n[0]}), .e(e), .o(seg[0]));
    m8_le CB(.in({n[3], 1'b1, ~n[3], n[3], n[3], 1'b0, 1'b0, 1'b0}), .sel({n[2], n[1], n[0]}), .e(e), .o(seg[1]));
    m8_le CC(.in({n[3], n[3], 1'b0, n[3], 1'b0, ~n[3], 1'b0, 1'b0}), .sel({n[2], n[1], n[0]}), .e(e), .o(seg[2]));
    m8_le CD(.in({1'b1, 1'b0, 1'b0, ~n[3], 1'b0, n[3], 1'b1, 1'b0}), .sel({n[2], n[1], n[0]}), .e(e), .o(seg[3]));
    m8_le CE(.in({~n[3], 1'b0, ~n[3], ~n[3], ~n[3], 1'b0, 1'b1, 1'b0}), .sel({n[2], n[1], n[0]}), .e(e), .o(seg[4]));
    m8_le CF(.in({~n[3], 1'b0, n[3], 1'b0, ~n[3], ~n[3], ~n[3], 1'b0}), .sel({n[2], n[1], n[0]}), .e(e), .o(seg[5]));
    m8_le CG(.in({~n[3], 1'b0, 1'b0, n[3], 1'b0, 1'b0, ~n[3], ~n[3]}), .sel({n[2], n[1], n[0]}), .e(e), .o(seg[6]));
    
    
endmodule
