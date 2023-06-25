## Vulnerability

Phishing with tx.origin

A -> B -> C

If contract A calls B, and B calls C, 
inside C, msg.sender is B and tx.origin is A



## Preventative Techniques

Use msg.sender instead of tx.origin

