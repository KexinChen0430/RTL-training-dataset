module VGA_Controller(
    input [3:0] iCursor_RGB_EN, 
    input [9:0] iCursor_X,      
    input [9:0] iCursor_Y,      
    input [9:0] iCursor_R,      
    input [9:0] iCursor_G,      
    input [9:0] iCursor_B,      
    input [9:0] iRed,           
    input [9:0] iGreen,         
    input [9:0] iBlue,          
    output reg [19:0] oAddress, 
    output reg [9:0] oCoord_X,  
    output reg [9:0] oCoord_Y,  
    output [9:0] oVGA_R,        
    output [9:0] oVGA_G,        
    output [9:0] oVGA_B,        
    output reg oVGA_H_SYNC,     
    output reg oVGA_V_SYNC,     
    output oVGA_SYNC,           
    output oVGA_BLANK,          
    output oVGA_CLOCK,          
    input iCLK,                 
    input iRST_N                
);
`include "VGA_Param.h"
reg [9:0] H_Cont;              
reg [9:0] V_Cont;              
reg [9:0] Cur_Color_R;         
reg [9:0] Cur_Color_G;         
reg [9:0] Cur_Color_B;         
wire mCursor_EN;               
wire mRed_EN;                  
wire mGreen_EN;                
wire mBlue_EN;                 
assign oVGA_BLANK = oVGA_H_SYNC & oVGA_V_SYNC; 
assign oVGA_SYNC = 1'b0;                       
assign oVGA_CLOCK = iCLK;                      
assign mCursor_EN = iCursor_RGB_EN[3];         
assign mRed_EN = iCursor_RGB_EN[2];            
assign mGreen_EN = iCursor_RGB_EN[1];          
assign mBlue_EN = iCursor_RGB_EN[0];           
assign oVGA_R = (H_Cont >= X_START + 9 && H_Cont < X_START + H_SYNC_ACT + 9 &&
                 V_Cont >= Y_START && V_Cont < Y_START + V_SYNC_ACT)
                ? (mRed_EN ? Cur_Color_R : 0) : 0;
assign oVGA_G = (H_Cont >= X_START + 9 && H_Cont < X_START + H_SYNC_ACT + 9 &&
                 V_Cont >= Y_START && V_Cont < Y_START + V_SYNC_ACT)
                ? (mGreen_EN ? Cur_Color_G : 0) : 0;
assign oVGA_B = (H_Cont >= X_START + 9 && H_Cont < X_START + H_SYNC_ACT + 9 &&
                 V_Cont >= Y_START && V_Cont < Y_START + V_SYNC_ACT)
                ? (mBlue_EN ? Cur_Color_B : 0) : 0;
always @(posedge iCLK or negedge iRST_N) begin
    if (!iRST_N) begin
        oCoord_X <= 0;
        oCoord_Y <= 0;
        oAddress <= 0;
    end else begin
        if (H_Cont >= X_START && H_Cont < X_START + H_SYNC_ACT &&
            V_Cont >= Y_START && V_Cont < Y_START + V_SYNC_ACT) begin
            oCoord_X <= H_Cont - X_START;
            oCoord_Y <= V_Cont - Y_START;
            oAddress <= oCoord_Y * H_SYNC_ACT + oCoord_X - 3;
        end
    end
end
always @(posedge iCLK or negedge iRST_N) begin
    if (!iRST_N) begin
        Cur_Color_R <= 0;
        Cur_Color_G <= 0;
        Cur_Color_B <= 0;
    end else begin
        if (H_Cont >= X_START + 8 && H_Cont < X_START + H_SYNC_ACT + 8 &&
            V_Cont >= Y_START && V_Cont < Y_START + V_SYNC_ACT) begin
            if (((H_Cont == X_START + 8 + iCursor_X) ||
                 (H_Cont == X_START + 8 + iCursor_X + 1) ||
                 (H_Cont == X_START + 8 + iCursor_X - 1) ||
                 (V_Cont == Y_START + iCursor_Y) ||
                 (V_Cont == Y_START + iCursor_Y + 1) ||
                 (V_Cont == Y_START + iCursor_Y - 1)) &&
                mCursor_EN) begin
                Cur_Color_R <= iCursor_R;
                Cur_Color_G <= iCursor_G;
                Cur_Color_B <= iCursor_B;
            end else begin
                Cur_Color_R <= iRed;
                Cur_Color_G <= iGreen;
                Cur_Color_B <= iBlue;
            end
        end else begin
            Cur_Color_R <= iRed;
            Cur_Color_G <= iGreen;
            Cur_Color_B <= iBlue;
        end
    end
end
always @(posedge iCLK or negedge iRST_N) begin
    if (!iRST_N) begin
        H_Cont <= 0;
        oVGA_H_SYNC <= 0;
    end else begin
        if (H_Cont < H_SYNC_TOTAL) begin
            H_Cont <= H_Cont + 1;
        end else begin
            H_Cont <= 0;
        end
        if (H_Cont < H_SYNC_CYC) begin
            oVGA_H_SYNC <= 0; 
        end else begin
            oVGA_H_SYNC <= 1; 
        end
    end
end
always @(posedge iCLK or negedge iRST_N) begin
    if (!iRST_N) begin
        V_Cont <= 0;
        oVGA_V_SYNC <= 0;
    end else begin
        if (H_Cont == 0) begin
            if (V_Cont < V_SYNC_TOTAL) begin
                V_Cont <= V_Cont + 1;
            end else begin
                V_Cont <= 0;
            end
            if (V_Cont < V_SYNC_CYC) begin
                oVGA_V_SYNC <= 0; 
            end else begin
                oVGA_V_SYNC <= 1; 
            end
        end
    end
end
endmodule 