import yaml
import os
import sys

def load_toc(file_path):
    print(f"Loading table of contents from {file_path}")
    try:
        with open(file_path, 'r') as file:
            toc = yaml.safe_load(file)
        print("Table of contents loaded successfully")
        return toc
    except FileNotFoundError:
        print(f"Error: File {file_path} not found", file=sys.stderr)
        sys.exit(1)
    except yaml.YAMLError as e:
        print(f"Error parsing YAML file: {e}", file=sys.stderr)
        sys.exit(1)

def load_template(file_path):
    print(f"Loading master template from {file_path}")
    try:
        with open(file_path, 'r') as file:
            template = file.read()
        print("Master template loaded successfully")
        return template
    except FileNotFoundError:
        print(f"Error: File {file_path} not found", file=sys.stderr)
        sys.exit(1)

def generate_yearly_indices(toc, template):
    print("Generating yearly indices")
    for chapter in toc['parts'][0]['chapters']:
        year = chapter['file'].split('/')[-2]
        print(f"\nProcessing year: {year}")
        
        problems = []
        for section in chapter['sections']:
            problem_title = section['file'].split('/')[-1].replace('-', ' ').rsplit('-', 1)[0]
            problems.append((problem_title, section['file']))
            print(f"  Found problem: {problem_title}")
        
        filled_template = template.format(
            year=year,
            problem_list='\n'.join(f"{i+1}. [{title}]({link})\n   Brief description of the problem." 
                                   for i, (title, link) in enumerate(problems))
        )
        
        output_dir = os.path.dirname(chapter['file'])
        print(f"  Creating directory: {output_dir}")
        os.makedirs(output_dir, exist_ok=True)
        
        output_file = f"{output_dir}/index.md"
        print(f"  Writing index file: {output_file}")
        with open(output_file, 'w') as file:
            file.write(filled_template)
        print(f"  Index file for {year} created successfully")

def main():
    print("Starting APL Quest yearly index generation")
    toc_file = '_toc.yml'
    template_file = 'master.md'
    
    toc = load_toc(toc_file)
    template = load_template(template_file)
    generate_yearly_indices(toc, template)
    
    print("\nIndex generation complete")

if __name__ == "__main__":
    main()
