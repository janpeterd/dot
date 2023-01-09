;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Jan-Peter Dhallé"
      user-mail-address "janpeter.dhalle@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; (setq doom-theme 'doom-gruvbox
(setq doom-theme 'doom-ir-black ; black theme
      fancy-splash-image "~/.doom.d/gnu.png")


(setq doom-font (font-spec :family "Hack Nerd Font Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 15)
      doom-big-font (font-spec :family "Hack Nerd Font Mono" :size 24))

(setq display-line-numbers-type 'visual
      display-time-24hr-format t
      display-time-day-and-date nil)
(display-time)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/doom/Notes")


;; Bookmark directory
(setq bookmark-default-file "~/.doom.d/bookmarks")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; add to $DOOkDIR/config.el

;; TRANSPARANCY
(set-frame-parameter (selected-frame) 'alpha '(90 . 85))
(add-to-list 'default-frame-alist '(alpha . (90 . 85)))

(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(90 . 85) '(100 . 100)))))

(map! :map toggle-transparency
      :leader
      :prefix ("t" . "toggle")
      :desc "toggle transparency"       "T" #'toggle-transparency)


;; Enable ccls for all c++ files, and platformio-mode only
;; when needed (platformio.ini present in project root).
(add-hook 'c++-mode-hook (lambda ()
                           (lsp-deferred)
                           (platformio-conditionally-enable)))


;; List bookmarks binding
(map! :leader
      (:prefix ("b". "buffer")
       :desc "List bookmarks" "L" #'list-bookmarks
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save))

;; This updates emacs buffer when the file gets modified from outside of emacs
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

;; DAP debugging in python
(require 'dap-python)

(after! dap-mode
  (setq dap-python-debugger 'debugpy))

(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug

      ;; debug
      :prefix ("dd" . "Debug")
      :desc "dap debug recent"  "r" #'dap-debug-recent
      :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      :prefix ("de" . "Eval")
      :desc "eval"                "e" #'dap-eval
      :desc "eval region"         "r" #'dap-eval-region
      :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      :desc "add expression"      "a" #'dap-ui-expressions-add
      :desc "remove expression"   "d" #'dap-ui-expressions-remove

      :prefix ("db" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)

;; Writeroom mode
(after! writeroom-mode
  (add-to-list 'writeroom-major-modes 'org-mode) ; add org-mode to the list of writeroom modes
  (setq writeroom-mode-line t) ; keep the modeline
)
(global-writeroom-mode)      ; automatically enable it for text and org-mode

;; Org
(after! org
  (setq org-agenda-files '("/home/jp/Documents/doom/Notes/todo.org")
        org-todo-keywords      ; This overwrites the default Doom org-todo-keywords
        ;; General Task management
        '((sequence
           "TODO(t)"           ; A task that is ready to be tackled
           "[ ](T)"            ; A subtask that can be ticked off
           "PROJ(p)"           ; A project that contains other tasks
           "APPOINTMENT(a)"    ; An appointment with someone
           "WAIT(w)"           ; Something is holding up this task
           "|"                 ; The pipe necessary to separate "active" states and "inactive" states
           "DONE(d)"           ; Task has been completed
           "CANCELLED(c)" )    ; Task has been cancelled

          ;; Tasks that have to do with School
          (sequence
           "SCHOOL(s)"         ; School tasks
           "EXAM(e)"           ; Big Exam
           "|" )               ; The pipe necessary to separate "active" states and "inactive" states

          (sequence
           "HEALTH(h)"         ; Health related
           "GROW(g)"           ; Personal Growth related
           "GOAL(G)"           ; A bigger lifegoal that needs to be planned
           "|" ))              ; The pipe necessary to separate "active" states and "inactive" states
        org-columns-default-format "%60ITEM(Task) %TODO %6Effort(Estim){:}  %6CLOCKSUM(Clock) %TAGS"
        org-agenda-prefix-format '((agenda . " %i %-12:c%?-12t%-6e% s")
                                   (todo . " %i %-12:c %-6e")
                                   (tags . " %i %-12:c")
                                   (search . " %i %-12:c"))))
 (setq hl-todo-keyword-faces
	'(("TODO"   . "#CC9393")
	  ("DEBUG"  . "#A020F0")
          ("HOLD"   . "#D0BF8F")
          ("NEXT"   . "#DCA3A3")
          ("THEM"   . "#DC8CC3")
          ("PROG"   . "#7CB8BB")
          ("OKAY"   . "#7CB8BB")
          ("SCHOOL" . "#A020F0")
          ("EXAM"   . "#FF0000")
          ("DONT"   . "#5F7F5F")
          ("FAIL"   . "#8C5353")
          ("DONE"   . "#AFD8AF")
          ("NOTE"   . "#D0BF8F")
          ("KLUDGE" . "#D0BF8F")
          ("HACK"   . "#D0BF8F")
          ("TEMP"   . "#D0BF8F")
          ("FIXME"  . "#CC9393")
          ("XXX+"   . "#CC9393")))
