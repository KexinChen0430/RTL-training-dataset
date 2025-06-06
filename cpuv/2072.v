module bsg_lfsr #(
    parameter `BSG_INV_PARAM(width_p), 
    init_val_p = 1, 
    xor_mask_p = 0  
) (
    input clk,      
    input reset_i,  
    input yumi_i,   
    output logic [width_p-1:0] o 
);
logic [width_p-1:0] o_r, o_n, xor_mask;
assign o = o_r;
if (xor_mask_p == 0)
    begin : automask
        case (width_p)
            32:
                assign xor_mask = (1 << 31) | (1 << 29) | (1 << 26) | (1 << 25);
            60:
                assign xor_mask = (1 << 59) | (1 << 58);
            64:
                assign xor_mask = (1 << 63) | (1 << 62) | (1 << 60) | (1 << 59);
            default:
                initial assert(width_p==-1)
                else
                    begin
                        $display("unhandled default mask for width %d in bsg_lfsr",width_p); $finish();
                    end
        endcase 
    end
else
    begin: fi
        assign xor_mask = xor_mask_p;
    end
always @(posedge clk)
    begin
        if (reset_i)
            o_r <= (width_p) ' (init_val_p);
        else if (yumi_i)
            o_r <= o_n;
    end
assign o_n = (o_r >> 1) ^ ({width_p {o_r[0]}} & xor_mask);
endmodule