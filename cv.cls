%
% CURRICULUM VITAE CUSTOM CLASS
% Author: Justin Vasel -- 2013


\typeout{Document Style `cv'.}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cv.sty
%
% \documentstyle{cv}
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Glue
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dimensions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sectionwidth	the amount that the section titles go in the
%		left margin
%
% resumewidth	the width of the total resume from the left
%		margin to the right.  Don't use textwidth
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sectionfont	the font used to print section titles
%		use \renewcommand to change it
%
% namefont	the font used to print your name
%		use \renewcommand to change it
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THINGS TO DO
%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}

\PassOptionsToClass{12pt}{article}
\LoadClassWithOptions{article}

\nofiles	     % Supress creation of .aux files

\RequirePackage{multicol}
\RequirePackage{color}
\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage[colorlinks=true, pdfstartview=FitV, linkcolor=blue, citecolor=blue, urlcolor=BrickRed]{hyperref}



%%%%%%%% NAME STUFF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ======================================================== %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this is used to print the name and address at the top of
% the page with a hline in between
%
\def\namefont{}
\def\addressfont{}
\def\namesize{\Huge}

\definecolor{light}{gray}{0.3}

\def\@linename{\begingroup
  \namesize\namefont\hspace{1ex}\@name
  \vskip 2pt
  \fullline
  \vskip 2pt
  \vspace{0.2in}
  \leftskip=0in
  % where do you live?
  \@ifundefined{@addressone}{%
    \normalsize
    \begin{multicols}{2}
      \textsf{CURRENT} \\
      {\color{light} \addressfont
      371 M. W. Allworth Hall \\
      1023 University Drive \\
      Duluth, MN 55812 \\
      Email: jvasel{@}indiana.edu \normalfont} \\ 
      \columnbreak
      
      \textsf{PERMANENT} \\
      {\color{light} \addressfont
      4122 Mill Run Road \\
      Eau Claire, WI 54703 \\
      Phone: +1 (715) 577-2090 \normalfont}
    \end{multicols}
  }{%
    %
  }
  \vspace{-0.2in}
  \@website
\endgroup}

\let\print@name\@linename

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% use this to define your name
%
\def\name#1{\def\@name{#1}}
\def\@name{}

\def\website#1#2{\def\@website{\normalfont \large \emph{\href{#1}{#2} } \normalsize}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% makes a line of width \textwidth starting at -\hoffset
%
\def\fullline{    % hrules only listen to \hoffset
  \nointerlineskip  % so I have this code   
  \moveleft\hoffset\vbox{\hrule width\textwidth} 
  \nointerlineskip
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% use this to define your address, this may be called more than once.
%
\let\@addressone\relax
\let\@addresstwo\relax

\def\address#1{
  \@ifundefined{@addressone}{\def\@addressone{#1}}{\def\@addresstwo{#1}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if you want to print your name and address is a slightly
% different format than sugessted, then this can be used
% to place it exactly where you want
%
\def\opening{
  \begingroup
  \leftskip=-\hoffset      % I use leftskip to move things to the left as 
  \advance\textwidth\hoffset % changing hoffset doesn't work. But this
  \hsize=\textwidth      % doesn't really work as hboxes are rules
           % are unaffeted
  \let\par=\@@par
  \parindent=0pt
  \parskip=0pt
  \print@name
  \endgroup
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% all of the resume goes in the resume environment
%
\newenvironment{resume}{\begingroup
           \opening
}{\endgroup}






%%%%%%%% SECTION STUFF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ======================================================== %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use this to set the sectionwidth.
% It adjust the width of the text as well as the hoffset
% You probably shouldn't touch any of the size paramaters
% unless you really understand all of this but it is not
% hard.  Either way, it can only be executed once
%
\def\sectionfont{\bf}
\newdimen\sectionwidth
\newskip\sectionskip
\newdimen\resumewidth

\resumewidth=6.5in
\sectionskip=0.4in

\def\newsectionwidth#1{%
		     \sectionwidth=#1
		     \textwidth=\resumewidth
		     \advance\textwidth-\sectionwidth
		     \hsize=\textwidth
		     \hoffset=\sectionwidth
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is for sectiontitles that are entirely in the left margin.
% multiline sectiontitles are permited and will be broken by
% \TeX{} to fit into a box \verb|\sectionwidth| wide.  It is advised
% that \verb|\\| be used to break the lines by hand as \TeX{} will
% probably not do what you want.
%
% When using this with {\tt tabbing} and {\tt list} (or anything
% that is made out of {\tt list}) put the \section's inside of
% the \verb|\begin{}|  and the \verb|\item|Eg.
% \begin{verbatim}
% \begin{trivlist}
% \item[]
% \section{foo}
% text
% \end{trivlist}
% \end{verbatim}
%
\def\boxed@sectiontitle#1{%
  % this macro may be called in a tabular.  Special code must be written
  % to accomodate this.  In LaTeX, a tabular is made out of hboxes.
  % TeX never goes into horizontal mode because of this; it only
  % gets into vertical mode and restricted horizontal mode.  Certain 
  % indenting problems must be handled because of this.  They
  % are delt with at the end of this routine.
  % It is also necessary to close the hbox that was created before
  % the \section and create a new one when this macro has ended.
  % This macro therefore simulates a \kill, so that any text before
  % the \section not be printed.  The proper use is therefore
  % ...
  % text\\
  % \section{foo}
  % more text\\
  % ...
  \ifx\\\@tabcr    % is this in a tabular? (this *should* work but is a cludge)
    \@stopfield    % the is the first part of a \kill
   \else
     \@@par	     % This will end the previous paragraph if needed and
		   % go into vertical mode.  If this was already in
		   % vertical mode then the \par does nothing.

  \fi
  \begingroup
  \everypar={}%
  \def\par{\@@par}%
  \let\\=\@normalcr
  \addpenalty{\@secpenalty} % this would be a good place for a page break
			    % \@secpenalty is what LaTeX uses before its
			    % section's.  It happens to be -300
  \addvspace{\sectionskip}  % put in a bit of glue
  % The following hbox will be contributed to the page list without going
  % into horizontal mode.  Therefore, any \parindent's, \parshape's, \leftskip
  % will be ignored but \hoffset's are not.  The result is that the box will
  % only by \hoffset. This is what I want
  \hbox to 0pt{%
    \hss	 % this is an llap.  In other words, this glue
		 % will shrink by the width of the stuff in the vbox
		 % (\sectionwidth) into the left margin and then
		 % insert the contents of the vbox.
    \vtop to 0pt{% make a 0pt height paragraph, with the baseline at the
		 % lined up with the baseline of the first box in the list
      \leftskip=0pt
      \hsize=\sectionwidth
      \textwidth=\sectionwidth
      \raggedright     % you don't want this filled out to the right margin
      \sectionfont
      #1\vss	       % Go into horizontal mode; do the paragraph;
		       % go into vertical mode; add some negative glue 
		       % to give a box of 0pt height and depth
    }%
  }%
  \addpenalty{-\@secpenalty} % this would be a bad place for a page break
  \vskip-\baselineskip % when the next box is processed, baselineskip glue
		       % glue will be added (the box has no depth because of
		       % the \vss; therefore, we don't have to worry about
		       % \lineskiplimit).  This -\baselineskip glue
		       % is to undo this.  \nointerlineskip doesn't
		       % work because the baseline of this line would be lined
		       % up with the top of the top of the next box.  We
		       % want the baselines lined up.
		       %
		       % It may have been possible to do this by forcing the
		       % baseline of this box to be the top of the box but
		       % then the interline skip between this box and the
		       % previous box would be off as the baselines of the
		       % this box (the one that being made above) and the
		       % previous line would be separated by \baselineskip
		       % (probably, it may be separted by the depth of the
		       % previous box + \lineskip) but as the baseline of
		       % this box has been moved to the top, the box's would
		       % separted by to much glue.  The exact amount being
		       % the height of this box.
  \endgroup
  \ifx\\\@tabcr   % is this in a tabular? (this *should* work but is a cludge)
    % this is the second part of the \kill; it starts the next tabbing line
    % Because this routine will never get into paragraph mode when used in
    % tabbing the \parskip that is discussed below will never be inserted.
    % Therefore it should not be negated as done below.
    \@startline
    \ignorespaces
  \else
    \vskip-\parskip    % The next thing to be contributed will be a paragraph.
		       % Right before being contributed though a \vskip\parskip
		       % will be inserted.  This is to negate it.
		       %
		       % I do consider this to be a bit of a cludge but
		       % I can not find a way to write \unskipfutureskip
		       % or a way to make TeX think that nothing has
		       % been contributed to the page list.
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Section headings

\newsectionwidth{1.3in}\let\@@section\boxed@sectiontitle


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFAULTS
%

\@secpenalty = -500
\topmargin 0pt
\headheight 0pt
\headsep 0pt
\textheight 9in
\parindent 0pt
\topmargin 0in
\oddsidemargin 0pt
\evensidemargin 0pt
\marginparwidth 0pt
\parindent 0pt
\parskip \baselineskip
\setcounter{secnumdepth}{0}
\def\@listI{\leftmargin\leftmargini
  \topsep 0pt 
  \parskip 0pt
  \partopsep 2pt plus 2pt
  \parsep 2pt plus 2pt
  \itemsep \parsep}

\pagestyle{empty}  % don't want page numbers

\let\section\@@section

