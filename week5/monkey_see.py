import sys
import subprocess
import tempfile
from IPython.display import display as ipy_display
from IPython.core.display import Image as IPyImage


def open_file_with_system_viewer(filepath):
    """Open a file with the system's default viewer."""
    if sys.platform == "darwin":
        subprocess.run(["open", filepath])
    elif sys.platform.startswith("linux"):
        subprocess.run(["xdg-open", filepath])
    elif sys.platform.startswith("win"):
        subprocess.run(["start", filepath], shell=True)
    else:
        raise RuntimeError(f"Unsupported platform: {sys.platform}")


def display(obj):
    """Display objects, opening images/plots in external viewer."""
    if isinstance(obj, IPyImage):
        # IPyImage has bytes in .data attribute
        with tempfile.NamedTemporaryFile(suffix=".png", delete=False) as tmp:
            tmp.write(obj.data)
            tmp_path = tmp.name
        open_file_with_system_viewer(tmp_path)

    elif hasattr(obj, "write_image"):  # Plotly figure
        with tempfile.NamedTemporaryFile(suffix=".png", delete=False) as tmp:
            tmp_path = tmp.name
        obj.write_image(tmp_path)
        open_file_with_system_viewer(tmp_path)

    else:
        # Fall back to IPython's default display
        ipy_display(obj)
