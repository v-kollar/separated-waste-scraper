from csv import DictReader, DictWriter
from typing import TextIO, Sequence


def filter_containers() -> None:
    with open('../data/containers.csv', 'r') as containers, \
         open('../data/containers-filtered.csv', 'w') as filtered:
        data: TextIO = containers
        reader = DictReader(data)  
        fieldnames: Sequence[str] = ['tid', 'nazev', 'verejnost']
        writer = DictWriter(filtered, fieldnames=fieldnames)
        writer.writeheader()

        for row in reader:
            is_paper = row['komodita_odpad_separovany'] == 'Papír'
            is_enough_volume = row['objem'].isdigit() and int(row['objem']) >= 500
            is_tuesday = row['vyvoz_2'] == 'A'
            is_public = row['verejnost'] == 'A'

            if is_paper and is_enough_volume and is_tuesday:
                writer.writerow({'tid': row['tid'],
                                 'nazev': row['nazev'],
                                 'verejnost': is_public})


if __name__ == '__main__':
    filter_containers()
