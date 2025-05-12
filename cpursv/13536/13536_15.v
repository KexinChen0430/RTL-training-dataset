
module done;

  reg  [31:0] a,b,c,d;

  
  initial  
  begin
    a = 32'hdeadbeef;
    b = 32'hfeedface;
    c = 32'hcafebabe;
    d = 32'hfacefeed;
    chacha20_qr(a,b,c,d);
    if ((a !== 32'hdeadbeef) || 
        ((c !== 32'hcafebabe) || (b !== 32'hfeedface)) || (d !== 32'hfacefeed)) 
      $display("chacha20_qr test failed -- a: %h b: %h c: %h d: %h",
               a,b,c,d);
    else 
      $display("chacha20_qr test passed -- a: %h b: %h c: %h d: %h",
               a,b,c,d);
    $display("Test done --");
    $finish;
  end
endmodule

