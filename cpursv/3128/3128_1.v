
module __MISTRAL_VCC(output Q);

  MISTRAL_ALUT2 #(.LUT(4'b1111)) _TECHMAP_REPLACE_(.A(1'b1),.B(1'b1),
                                                   .Q(Q));
endmodule

