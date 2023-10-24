"""Tasks for compiling the paper and presentation(s)."""
import shutil

import pytask
from pytask_latex import compilation_steps as cs
from topics_in_behavioural_decision_theory.config import BLD, PAPER_DIR

documents = ["00_outline", "01_introduction", "01_lecture_lingnan"]

for document in documents:

    @pytask.mark.latex(
        script=PAPER_DIR / f"{document}.tex",
        document=BLD / "latex" / f"{document}.pdf",
        compilation_steps=cs.latexmk(
            options=("--pdf", "--interaction=nonstopmode", "--synctex=1", "--cd"),
        ),
    )
    @pytask.mark.task(id=document)
    def task_compile_document():
        """Compile the document specified in the latex decorator."""

    kwargs = {
        "depends_on": BLD / "latex" / f"{document}.pdf",
        "produces": BLD.parent.resolve() / f"{document}.pdf",
    }

    @pytask.mark.task(id=document, kwargs=kwargs)
    def task_copy_to_root(depends_on, produces):
        """Copy a document to the root directory for easier retrieval."""
        shutil.copy(depends_on, produces)
