import services.careBridgeService;
import from .components.CareBridgeWorkspace { CareBridgeWorkspace }
import ".styles.global.css";

def:pub app() -> JsxElement {
    return <CareBridgeWorkspace />;
}
