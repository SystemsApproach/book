Foreword to the First Edition
=============================

The term *spaghetti code* is universally understood as an insult. All good
computer scientists worship the god of modularity, since modularity
brings many benefits, including the all-powerful benefit of not having to
understand all parts of a problem at the same time in order to solve it.
Modularity thus plays a role in presenting ideas in a book, as well as in
writing code. If a book’s material is organized
effectively—Modularly—the reader can start at the
beginning and actually make it to the end.

The field of network protocols is perhaps unique in that the “proper”
modularity has been handed down to us in the form of an international
standard: the seven-layer reference model of network protocols from
the ISO. This model, which reflects a layered approach to modularity, is
almost universally used as a starting point for discussions of protocol
organization, whether the design in question conforms to the model or
deviates from it.

It seems obvious to organize a networking book around this layered
model. However, there is a peril to doing so, because the OSI model
is not really successful at organizing the core concepts of networking.
Such basic requirements as reliability, flow control, or security can be
addressed at most, if not all, of the OSI layers. This fact has led to
great confusion in trying to understand the reference model. At times it
even requires a suspension of disbelief. Indeed, a book organized strictly
according to a layered model has some of the attributes of spaghetti
code.

Which brings us to this book. Peterson and Davie follow the traditional
layered model, but they do not pretend that this model actually
helps in the understanding of the big issues in networking. Instead, the
authors organize discussion of fundamental concepts in a way that is
independent of layering. Thus, after reading the book, readers will understand
flow control, congestion control, reliability enhancement, data
representation, and synchronization, and will separately understand
the implications of addressing these issues in one or another of the traditional
layers.

This is a timely book. It looks at the important protocols in use
today—especially the Internet protocols. Peterson and Davie have a long involvement
in and much experience with the Internet. Thus their book reflects
not just the theoretical issues in protocol design, but the real factors that
matter in practice. The book looks at some of the protocols that are just
emerging now, so the reader can be assured of an up-to-date perspective.
But most importantly, the discussion of basic issues is presented in
a way that derives from the fundamental nature of the problem, not the
constraints of the layered reference model or the details of today’s protocols.
In this regard, what this book presents is both timely and timeless.
The combination of real-world relevance, current examples, and careful
explanation of fundamentals makes this book unique.



| David Clark
| Massachusetts Institute of Technology
| 1996
