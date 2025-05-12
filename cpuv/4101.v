module MISTRAL_FF(
    input DATAIN,  
    input CLK,     
    input ACLR,    
    input ENA,     
    input SCLR,    
    input SLOAD,   
    input SDATA,   
    output reg Q   
);
    dffeas #(
        .power_up("low"),
        .is_wysiwyg("true")
    ) _TECHMAP_REPLACE_ (
        .d(DATAIN),    
        .clk(CLK),     
        .clrn(ACLR),   
        .ena(ENA),     
        .sclr(SCLR),   
        .sload(SLOAD), 
        .asdata(SDATA),
        .q(Q)          
    );
endmodule