from matplotlib import animation
import numpy as np
import datetime
import dateutil.parser
import glob
from matplotlib import pyplot as plt
from matplotlib.animation import FuncAnimation
import pandas as pd

names_df = None
# These need to be filled out
json_path = ""
names_path = ""


def main():
    json_files = load_data()
    dfs = [pd.read_json(x).head(10) for x in json_files]

    plt.rcdefaults()
    plt.style.use('Solarize_Light2')
    fig, ax = plt.subplots()
    labels = []
    x, y = [], []
    scat = ax.scatter(x, y)
    plt.xlim(0, 10)
    plt.ylim(0, 60)

    def animate(i):
        for _, a in enumerate(labels):
            a.remove()
        labels[:] = []
        ax.set_title(get_date(json_files[i % len(dfs)]).strftime("%B %Y"))
        df = dfs[i % len(dfs)]
        x = range(len(df))
        y = df['score']
        plt.ylim(0, max(df['score'].max(), 60))
        for index, txt in df['name'].iteritems():
            labels.append(ax.annotate((txt), (x[index], y[index])))
        scat.set_offsets(np.c_[x, y])

    ani = FuncAnimation(fig, animate,
                        frames=200, interval=1000, blit=False, repeat=True)
    plt.show()


def get_date(string):
    return dateutil.parser.isoparse(string.split('/')[-1].split('.')[0])


def load_data():
    json_files = glob.glob(json_path + "*.json")
    json_files.sort(key=get_date)
    return json_files


def random_name(name):
    global names_df
    if names_df is None:
        name_file = names_path
        names_df = pd.read_csv(name_file).head(1000)
    return names_df['FirstForename'][hash(name) % names_df.shape[0]]


if __name__ == "__main__":
    main()
