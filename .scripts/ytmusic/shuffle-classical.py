#!/usr/bin/env python

from ytmusicapi import YTMusic, OAuthCredentials
import random
import time

with open("/home/elliot/.scripts/ytmusic/secret") as secrets:
    id = secrets.readline()[:-1]
    secret = secrets.readline()[:-1]
    print(id)
    print(secret)
    ytmusic = YTMusic('/home/elliot/.scripts/ytmusic/oauth.json', oauth_credentials=OAuthCredentials(client_id=id, client_secret=secret))

lengths = [4, 1, 3, 4, 1, 1, 3, 4, 3, 4, 3, 3, 4, 3, 4, 5, 3, 3, 4, 4, 4, 3]

print("Accessing playlist...")
with open("/home/elliot/.scripts/ytmusic/playlistIDs") as id_file:
    piecesID = id_file.readline()[:-1]
    # print(piecesID)
    pieces = ytmusic.get_playlist(piecesID)
    album_length = len(pieces["tracks"])

    shuffledID = id_file.readline()[:-1]
    shuffled = ytmusic.get_playlist(shuffledID)

def calculate_indices(lengths):
    index = 0
    indices = []
    for length in lengths:
        indices.append(index)
        index += length
    return indices

def remove_old_tracks():
    old_tracks = []
    for track in shuffled["tracks"]:
        old_tracks.append(track)

    if len(old_tracks) > 0:
        ytmusic.remove_playlist_items(shuffledID, old_tracks)

def shuffle(indices):
    shuffled_incides = list(range(len(indices)))
    # Fisher-Yates shuffle
    for i in range(len(shuffled_incides) - 1, 0, -1):
        j = random.randint(0, i)
        shuffled_incides[i], shuffled_incides[j] = shuffled_incides[j], shuffled_incides[i]

    return shuffled_incides

indices = calculate_indices(lengths)
print("Removing old tracks...")
remove_old_tracks()
tracknums = shuffle(indices)
videoIds = []

for track_num in range(len(tracknums)):
    # Get the number of movements in the piece
    next_piece = tracknums[track_num] + 1
    # print(tracknums[track_num])
    # print(next_piece)
    movements = (indices[next_piece % len(indices)] - indices[tracknums[track_num]]) % album_length
    # print(movements)
    # Add the trackIDs to a list
    for movement in range(movements):
        videoIds.append(pieces["tracks"][indices[tracknums[track_num]] + movement]["videoId"])

print(f"Uploading {len(tracknums)} pieces...")
# Add the trackIDs to the new playlist
ytmusic.add_playlist_items(shuffledID, videoIds);

print("done")
