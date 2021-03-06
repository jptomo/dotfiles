;;
;; 関数定義
;;

;; load-path を追加する関数を定義
(defun my:add-to-load-path (&rest paths)
    (let (path)
        (dolist (path paths paths)
            (let
                ((default-directory
                    (expand-file-name
                        (concat user-emacs-directory path))))
                (add-to-list 'load-path default-directory)
                (if (fboundp 'normal-top-level-add-subdir-to-load-path)
                    (normal-top-level-add-subdirs-to-load-path))))))
