;;; evil-visualstar.el --- Starts a * or # search from the visual selection

;; Copyright (C) 2013 by Bailey Ling
;; Filename: evil-visualstar.el
;; Description: Starts a * or # search from the visual selection
;; Author: Bailey Ling
;; Created: 2013-09-24
;; Version: 0.0.0
;; Keywords: evil visualstar
;; Package-Requires: (evil)
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Commentary:

;;; Code:

(require 'evil)

;;;###autoload
(defun evil-visualstar/begin-search (beg end direction)
  (when (evil-visual-state-p)
    (evil-exit-visual-state)
    (let ((selection (regexp-quote (buffer-substring-no-properties beg end))))
      (if (eq evil-search-module 'isearch)
          (progn
            (setq isearch-forward direction)
            (evil-search selection direction t))
        (let ((pattern (evil-ex-make-search-pattern selection))
              (direction (if direction 'forward 'backward)))
          (setq evil-ex-search-direction direction)
          (setq evil-ex-search-pattern pattern)
          (evil-ex-search-activate-highlight pattern)
          (evil-ex-search-next))))))

;;;###autoload
(defun evil-visualstar/begin-search-forward (beg end)
  "Search for the visual selection in forward direction."
  (interactive "r")
  (evil-visualstar/begin-search beg end t))

;;;###autoload
(defun evil-visualstar/begin-search-backward (beg end)
  "Search for the visual selection in backward direction."
  (interactive "r")
  (evil-visualstar/begin-search beg end nil))

(define-key evil-visual-state-map (kbd "*") 'evil-visualstar/begin-search-forward)
(define-key evil-visual-state-map (kbd "#") 'evil-visualstar/begin-search-backward)

(provide 'evil-visualstar)

;;; evil-visualstar.el ends here
