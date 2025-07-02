from dataclasses import dataclass

@dataclass
class Project:
    name: str
    tasks: dict[str, bool] # name: done

    def progress(self) -> int:
        if not self.tasks:
            return 0
        return round(100 * sum(self.tasks.values()) / len(self.tasks))