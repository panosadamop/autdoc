
import re

def generate_mermaid_diagram(file_path: str, content: str) -> str:
    if file_path.endswith(".sql"):
        return parse_sql_to_er(content)
    elif file_path.endswith(".java"):
        return parse_java_to_class_diagram(content)
    return ""

def parse_sql_to_er(sql: str) -> str:
    tables = re.findall(r"CREATE TABLE (\w+) \((.*?)\);", sql, re.DOTALL)
    diagram = ["erDiagram"]
    for table, fields_blob in tables:
        fields = fields_blob.strip().split(",\n")
        for field in fields:
            parts = field.strip().split()
            if len(parts) >= 2:
                diagram.append(f"  {table} {{ {parts[1]} {parts[0]} }}")
    return "\n".join(diagram)

def parse_java_to_class_diagram(java: str) -> str:
    class_match = re.search(r"class (\w+)", java)
    class_name = class_match.group(1) if class_match else "UnknownClass"
    fields = re.findall(r"(private|protected|public) (\w+) (\w+);", java)
    diagram = [f"classDiagram", f"class {class_name} {{"]
    for _, typ, name in fields:
        diagram.append(f"  {typ} {name}")
    diagram.append("}")
    return "\n".join(diagram)
