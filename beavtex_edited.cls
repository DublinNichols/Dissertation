\LoadClass[b5paper, openright,twoside,11pt]{memoir}

\newcommand{\filename}{beavtex_edited}
\newcommand{\fileversion}{v1.1}
\newcommand{\filedate}{2013/12/05}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{\filename}[\filedate\space\fileversion\space BeavTeX: OSU thesis class]

\RequirePackage{setspace}
\RequirePackage{ifthen}
\RequirePackage[normalem]{ulem}
\newcommand{\ulinewithbreaks}[1]{\expandafter\uline\expandafter{#1}}



% User definitions.
% A definition generator for variables.
% #1: optional default value, if missing, the variable is mandatory. Failing to
% define it will raise a latex error.
% #2: command to define the variable
% \define{somevar} will define a new command \somevar with 1 parameter. It
% stores the contents to a variable \@somevar.

\newcommand{\definevar}[2][-]{%
  \expandafter\def\csname #2\endcsname{%
    \expandafter\gdef\csname @#2\endcsname
  }
  \if#1-
  \csname #2\endcsname{\@latex@error{No #2 defined}\@ehc}
  \else
  \csname #2\endcsname{#1}
  \fi
}

\definevar{title}
\definevar{author}
\definevar{doctype}
\definevar{degree}
\definevar{major}
\definevar{department}
\definevar{advisor}

\definevar[*]{twomajor}
\definevar[*]{twodepartment}
\definevar[*]{coadvisor}

\definevar[Chair]{depthead}
\definevar[Chair]{twodepthead}
\definevar[Department]{depttype}
\definevar[Department]{twodepttype}

\definevar[\today]{submitdate}
\definevar[\the\year]{commencementyear}

\definevar{abstract}
\definevar[*]{nopretext}

% \xxxcontent commands will be generated when we generate definitions for the
% pretext pages. the following definitions provide backward compatibility and
% nicer names.
\newcommand{\acknowledgements}{\ackcontent}
\newcommand{\contributors}{\contricontent}
\newcommand{\preface}{\prefcontent}
\newcommand{\dedication}{\dedcontent}

%-------------------------------------------------------------------------------
% Document parts. See T.G.
%-------------------------------------------------------------------------------
\newcommand{\emptyline}{\mbox{}\newline}

\newcommand{\advisorstring}{%
  \hfill
  \if\@coadvisor * \@advisor
  \else \@advisor\hfill\@coadvisor
  \fi 
  \hfill
}

% Flyleaf, a blankpage
\newcommand{\flyleaf}{\thispagestyle{empty}\phantom{}\newpage}

% Abstract page
\newcommand{\abspage}{
  \pagestyle{empty}
  \begin{doublespacing} 
    \begin{center} 
      {\heading AN ABSTRACT OF THE \MakeUppercase{\@doctype} OF}
    \end{center}
    \begin{flushleft}
      \noindent
      \ulinewithbreaks{\@author} for the degree of \ulinewithbreaks{\@degree} in%
      \if\@twomajor * \ulinewithbreaks{\@major}
      \else
      \ulinewithbreaks{\@major} and \ulinewithbreaks{\@twomajor}
      \fi
      presented on \uline{\@submitdate}.\\
      \emptyline
      \noindent Title: \ulinewithbreaks{\@title}
    \end{flushleft}
    \emptyline
    Abstract approved: \hrulefill \\
    \phantom{Abstract approved:\ }\advisorstring
    \vspace{1em}
  \end{doublespacing}
  \noindent
  \emptyline
  \emptyline
  \@abstract
  \clearpage
}

% Copyright page
\newcommand{\copyrightpage}{
  \begin{singlespacing}
  \thispagestyle{empty}
  \vspace*{10\baselineskip}
  \begin{center}
    ${}^\copyright$Copyright by \@author\\
    \@submitdate \\
    All Rights Reserved
  \end{center}
  \end{singlespacing}
  \clearpage
}

% Title page
\newcommand{\titlepage}{
    \thispagestyle{empty}
    \begin{center}
      \setlength{\baselineskip}{14.5pt}
      {\heading \@title} \\
      \emptyline by\\ \emptyline
      \@author\\
      \vfill
      A \MakeUppercase{\@doctype}\\ \emptyline
      submitted to\\ \emptyline
      Oregon State University\\
      \vfill
      in partial fulfillment of\\
      the requirements for the\\
      degree of\\ \emptyline
      \@degree
      \vfill
      Presented \@submitdate\\
      Commencement June \@commencementyear
    \end{center}
  \clearpage
}

% Approval page
\newcommand{\approvalpage}{
  \thispagestyle{empty}
  \begin{singlespacing}
    \begin{flushleft}
      \noindent
      \ulinewithbreaks{\@degree} \MakeLowercase{\@doctype} of \ulinewithbreaks{\@author} 
      presented on \uline{\@submitdate}. \\
      \vspace{3em}
      APPROVED:\\
      \vspace{3em}
      \hrulefill \\
      % Major Professor (Co- if there is a coadvisor}
      \if\@coadvisor *
      \else Co-\fi Major Professor, representing \@major \\
      \vspace{3em}
      % Second major professor if exists
      \if\@coadvisor *
      \else\hrulefill \\  Co-Major Professor, representing \@twomajor \\
      \vspace{3em}
      \fi
      \hrulefill \\ 
      % major department head
      \@depthead\ of the \@depttype\ of \@department \\
      \vspace{3em}
      \if\@twodepartment * 
      \else
      % Here is the second Department
      \hrulefill \\ 
      \@twodepthead\ of the \@twodepttype\ of \@twodepartment \\
      \vspace{3em}
      \fi
      \hrulefill \\
      Vice Provost and Dean of the Graduate School \\
      \vfill
      I understand that my \MakeLowercase{\@doctype} will become part of the
      permanent collection of Oregon State University libraries. My signature
      below authorizes release of my \MakeLowercase{\@doctype} to any reader
      upon request.
      \vspace{3em} \\
      \hrulefill \\
      \makebox[\textwidth]{\hfill \@author, Author \hfill}
    \end{flushleft}
  \end{singlespacing}
  \clearpage
}

\definevar[*]{dedcontent}
\newcommand{\dedpage}{
  \if \@dedcontent *
  \else
  \thispagestyle{empty}
  \vspace*{10\baselineskip}
  \begin{center}
  \@dedcontent
  \end{center}
  \clearpage
  \fi
}

% A definition generator for general pretext pages.
% #1: short name
% #2: page title
% \definepretextpage{name}{title} generates a command \namepage, \namecontent,
% a internal variable \@namecontent, and an environment \namepageenv.
% Authors: Use \namecontent to define the contents to be displayed. If it is not
% specified, the page will not be produced. You can also change the environment
% by using \renewenvironment{namepageenv}.

\newcommand{\definepretextpage}[2]{%
  \definevar[*]{#1content}
  \expandafter\newcommand\csname #1page\endcsname{%
    \if\csname @#1content\endcsname *
    \else
    \thispagestyle{empty}
    \begin{center}
      {\heading #2}
    \end{center}
    \noindent
    \emptyline
    \csname @#1content\endcsname
    \clearpage
    \fi
  }
}

% Acknowledgements, contribution, dedication, and preface.
\definepretextpage{ack}{ACKNOWLEDGEMENTS}
\definepretextpage{contri}{CONTRIBUTION OF AUTHORS}
\definepretextpage{pref}{PREFACE}

% Format all of the frontmatter
% The commands for optional pages will check if the content is defined. If not,
% the page will not be produced. There is no need to check here.
\newcommand{\pretext}{%
  \pagenumbering{roman}
  
  % Mandatory pages
  % \flyleaf           % A. Flyleaf
  \abspage           % B. Abstract
  \copyrightpage     % C. Copyright page
  \titlepage         % D. Title page
  \approvalpage      % E. Approval page

  % Optional pages
  \ackpage           % F. Acknowledgments
  \contripage        % G. Contribution of authors

  % Listings
  \tableofcontents        % H.
  \listoffigures          % I.
  \listoftables           % J

	% Algorithm listing
	\ifthenelse{\isundefined{\listofalgorithms}}{}{
  \expandafter\newcommand\csname ps@loaa\endcsname{
  \renewcommand{\@oddhead}{%
  \parbox{\textwidth}{%
  \centering {\heading LIST OF ALGORITHMS} \\ 
  \uline{Algorithm}\hfill\uline{Page}}}
  \renewcommand{\@oddfoot}{}
  \renewcommand{\@evenfoot}{}}
  \expandafter\newcommand\csname ps@loab\endcsname{%
  \renewcommand{\@oddhead}{%
  \parbox{\textwidth}{%
  \centering {\heading LIST OF ALGORITHMS\ (Continued)} \\ 
  \uline{Algorithm}\hfill\uline{Page}}}
  \renewcommand{\@evenhead}{\@oddhead}
  \renewcommand{\@oddfoot}{}
  \renewcommand{\@evenfoot}{}}
	\renewcommand{\listalgorithmname}{\pagestyle{loab}\thispagestyle{loaa}\vspace{-1.28in}}
  \listofalgorithms
  }

  \listofappendices       % K.
  \listofappendixfigures  % L.
  \listofappendixtables   % M.

  % Optional pages
  \dedpage           % O. Dedication
  \prefpage          % P. Preface
}

\renewcommand{\maketitle}{\if\@nopretext \else\pretext\fi}
