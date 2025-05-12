module playfields
(
    input   [6:1] bpldata,           
    input   dblpf,                   
    input   [6:0] bplcon2,           
    output  reg [2:1] nplayfield,    
    output  reg [5:0] plfdata        
);
wire pf2pri;                        
wire [2:0] pf2p;                    
assign pf2pri = bplcon2[6];         
assign pf2p = bplcon2[5:3];         
always @(dblpf or bpldata)
begin
    if (dblpf) 
    begin
        nplayfield[1] = |bpldata[5:1:2];
        nplayfield[2] = |bpldata[6:2:2];
    end
    else 
    begin
        nplayfield[1] = 0; 
        nplayfield[2] = |bpldata[6:1];
    end
end
always @(nplayfield or dblpf or pf2pri or bpldata or pf2p)
begin
    if (dblpf) 
    begin
        if (pf2pri) 
        begin
            if (nplayfield[2])
                plfdata = {3'b001, bpldata[6], bpldata[4], bpldata[2]};
            else if (nplayfield[1])
                plfdata = {3'b000, bpldata[5], bpldata[3], bpldata[1]};
            else 
                plfdata = 6'b000000;
        end
        else 
        begin
            if (nplayfield[1])
                plfdata = {3'b000, bpldata[5], bpldata[3], bpldata[1]};
            else if (nplayfield[2])
                plfdata = {3'b001, bpldata[6], bpldata[4], bpldata[2]};
            else 
                plfdata = 6'b000000;
        end
    end
    else 
    begin
        if (pf2p > 5 && bpldata[5])
            plfdata = {6'b010000}; 
        else
            plfdata = bpldata[6:1]; 
    end
end
endmodule