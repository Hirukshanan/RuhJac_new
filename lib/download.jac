# Browser-only download boundary; browser globals are not represented in Jac check stubs.
def:pub trigger_download(text: str) -> None {
    # jac:ignore[W2001]
    anchor: any = document.createElement("a");
    # jac:ignore[E1032]
    anchor.href = "data:text/plain;charset=utf-8," + encodeURIComponent(text);
    # jac:ignore[E1032]
    anchor.download = "carebridge-handover.txt";
    # jac:ignore[E1032]
    anchor.click();
}
