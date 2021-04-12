((nil . ((eval . (progn
                   (defvar tt-central-mode-map (make-sparse-keymap)
                     "Keymap while tt-central-mode is active.")

                   (define-minor-mode tt-central-mode
                     "A temporary minor mode to be activated only specific to a buffer."
                     nil
                     :lighter " [tt-central]"
                     tt-central-mode-map)

                   (tt-central-mode 1)

                   (defun oats/tt-central-run ()
                     (interactive)
                     (let* ((mk-dir (locate-dominating-file (buffer-file-name) "Makefile"))
                            (compile-command (concat "make -k -C " (shell-quote-argument mk-dir) " run"))
                            (compilation-read-command nil))
                       (call-inter.actively 'compile)))

                   (defun oats/tt-central-gdb ()
                     (interactive)
                     (gdb (string-join `("arm-none-eabi-gdb -i=mi"
                                         "-cd" ,(locate-dominating-file (buffer-file-name) "gdbinit")
                                         "-x ./gdbinit"
                                         "./build/tt-central.elf")
                                       " ")))

                   (define-key tt-central-mode-map
                     (kbd "C-c C-g") 'oats/tt-central-gdb)
                   (define-key tt-central-mode-map
                     (kbd "C-c C-r") 'oats/tt-central-run))))))
