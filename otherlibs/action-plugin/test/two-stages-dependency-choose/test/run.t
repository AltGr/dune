In this test client choose what to depend
on based on dependency from the previous stage.

  $ echo "(lang dune 2.0)" > dune-project

  $ cat > dune << EOF
  > (rule
  >  (target bar)
  >  (action
  >   (progn
  >    (echo "Building bar!\n")
  >    (with-stdout-to %{target} (echo "Hello from bar!")))))
  > \
  > (rule
  >  (target foo)
  >  (action
  >   (progn
  >    (echo "SHOULD NOT BE PRINTED!\n")
  >    (with-stdout-to %{target} (echo "Hello from foo!")))))
  > \
  > (rule
  >  (target foo_or_bar)
  >  (action (with-stdout-to %{target} (echo "bar"))))
  > \
  > (alias
  >  (name runtest)
  >  (action (dynamic-run ./client.exe)))
  > EOF

  $ cp ../bin/client.exe ./

  $ dune runtest --display short
        client alias runtest
        client alias runtest
  Building bar!
        client alias runtest
  Hello from bar!
