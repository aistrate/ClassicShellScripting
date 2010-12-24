#! /bin/sh -
IFS='
 	'

cd /home
du -s *      |
  sort -nr   |
    sed 10q  |
      while read amount name
      do
        mail -s "disk usage warning" $name &lt;&lt;- EOF
          Greetings. You are one of the top 10 consumers
          of disk space on the system.  Your home directory
          uses $amount disk blocks.

          Please clean up unneeded files, as soon as possible.

          Thanks,

          Your friendly neighborhood system administrator.
          EOF
      done
