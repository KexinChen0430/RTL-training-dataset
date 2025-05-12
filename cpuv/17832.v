module FRAME_ECCE2 (...);
    parameter FARSRC = "EFAR";
    parameter FRAME_RBT_IN_FILENAME = "NONE";
    output CRCERROR;
    output ECCERROR;
    output ECCERRORSINGLE;
    output SYNDROMEVALID;
    output [12:0] SYNDROME;
    output [25:0] FAR;
    output [4:0] SYNBIT;
    output [6:0] SYNWORD;
endmodule