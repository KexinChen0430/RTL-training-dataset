module plaintext_ip( 
      plaintxt, 
      left_out, 
      right_out, 
      select 
    );
    input [64:1] plaintxt; 
    output [32:1] left_out; 
    output [32:1] right_out; 
    input select; 
    reg [64:1] ip; 
    assign right_out= ip[32:1] ; 
    assign left_out= ip[64:33]; 
    always@(select) 
    begin
        if(select ==1) 
        begin
            ip[1]<= plaintxt[58];
            ip[2]<= plaintxt[50];
            ip[64]<= plaintxt[7];
        end
        else
            ip[64:1] <= 64'bx; 
    end
endmodule