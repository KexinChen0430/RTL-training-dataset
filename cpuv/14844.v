module T_FRAG (TBS, XAB, XSL, XA1, XA2, XB1, XB2, XZ);
    input  wire TBS;
    input  wire XAB;
    input  wire XSL;
    input  wire XA1;
    input  wire XA2;
    input  wire XB1;
    input  wire XB2;
    (* DELAY_CONST_TBS="{iopath_TBS_CZ}" *)
    (* DELAY_CONST_XAB="{iopath_TAB_TZ}" *)
    (* DELAY_CONST_XSL="{iopath_TSL_TZ}" *)
    (* DELAY_CONST_XA1="{iopath_TA1_TZ}" *)
    (* DELAY_CONST_XA2="{iopath_TA2_TZ}" *)
    (* DELAY_CONST_XB1="{iopath_TB1_TZ}" *)
    (* DELAY_CONST_XB2="{iopath_TB2_TZ}" *)
    output wire XZ;
    specify
        (TBS => XZ) = (0,0);
        (XAB => XZ) = (0,0);
        (XSL => XZ) = (0,0);
        (XA1 => XZ) = (0,0);
        (XA2 => XZ) = (0,0);
        (XB1 => XZ) = (0,0);
        (XB2 => XZ) = (0,0);
    endspecify
    parameter [0:0] XAS1 = 1'b0;
    parameter [0:0] XAS2 = 1'b0;
    parameter [0:0] XBS1 = 1'b0;
    parameter [0:0] XBS2 = 1'b0;
    wire XAP1 = (XAS1) ? ~XA1 : XA1;
    wire XAP2 = (XAS2) ? ~XA2 : XA2;
    wire XBP1 = (XBS1) ? ~XB1 : XB1;
    wire XBP2 = (XBS2) ? ~XB2 : XB2;
    wire XAI = XSL ? XAP2 : XAP1;
    wire XBI = XSL ? XBP2 : XBP1;
    wire XZI = XAB ? XBI : XAI;
    assign XZ = TBS ? XZI : 1'b0;
endmodule